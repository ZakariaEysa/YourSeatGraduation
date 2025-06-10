
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/features/admin_flow/moives/data/movies_cubit/movies_state.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';
import '../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../utils/loading_indicator.dart';

class MovieCubit extends Cubit<MovieState> {
  final TextEditingController movieNameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController promoLinkController = TextEditingController();
  final TextEditingController storyLineController = TextEditingController();
  final TextEditingController directorController = TextEditingController();
  final TextEditingController writerController = TextEditingController();
  final TextEditingController producerController = TextEditingController();
  final TextEditingController versionController = TextEditingController();

  PlatformFile? pickedCover;
  List<TextEditingController>? actorControllers;
  List<PlatformFile?> pickedActorImages = [];
  List<PlatformFile?> pickedDirectorImages = [];
  List<PlatformFile?> pickedWriterImages = [];
  List<PlatformFile?> pickedProducerImages = [];
  List<dynamic> ahmed = [];
  String? selectedGenre;
  String? selectedLanguage;
  String? selectedCensorship;
  String? selectedStatus;
  int? currentIndex;
  PlatformFile? coverPhoto;
  List<Map<String, dynamic>>? fetchedCinemaMovies;

  MovieCubit() : super(MovieInitial());

  static MovieCubit get(context) => BlocProvider.of<MovieCubit>(context);

  String extractUsername(String email) => email.split('@')[0];

  Future<String?> convertImageToBase64(PlatformFile file) async {
    try {
      final bytes = file.bytes;
      if (bytes == null) return null;
      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Error converting image to Base64: $e');
    }
  }

  Future<List<String>> convertImagesListToBase64(
      List<PlatformFile?> images) async {
    List<String> base64List = [];
    for (final imageFile in images) {
      if (imageFile != null) {
        final base64 = await convertImageToBase64(imageFile);
        if (base64 != null) base64List.add(base64);
      }
    }
    return base64List;
  }

  Future<Map<String, dynamic>> prepareMovieData() async {
    String? coverBase64;
    if (pickedCover != null) {
      coverBase64 = await convertImageToBase64(pickedCover!);
    }
    List<String> actorImagesBase64 =
        await convertImagesListToBase64(pickedActorImages);
    List<String> crewImagesBase64 = [
      ...(await convertImagesListToBase64(pickedDirectorImages)),
      ...(await convertImagesListToBase64(pickedWriterImages)),
      ...(await convertImagesListToBase64(pickedProducerImages)),
    ];

    Map<String, String> crew = {
      'director': directorController.text,
      'producer': producerController.text,
      'writer': writerController.text,
    };

    return {
      'release_date': versionController.text,
      'name': movieNameController.text,
      'duration': durationController.text,
      'trailer': promoLinkController.text,
      'category': selectedGenre,
      'language': selectedLanguage,
      'age_rating': selectedCensorship,
      'status': selectedStatus,
      'poster_image': coverBase64,
      'description': storyLineController.text,
      'crew': crew,
      'crew_images': {
        'director': crewImagesBase64.isNotEmpty ? crewImagesBase64[0] : '',
        'writer': crewImagesBase64.length > 1 ? crewImagesBase64[1] : '',
        'producer': crewImagesBase64.length > 2 ? crewImagesBase64[2] : '',
      },
      'rating': 0,
      'cast': actorControllers?.map((c) => c.text).toList() ?? [],
      'cast_images': actorImagesBase64,
    };
  }

  Future<void> uploadMovieToFireStore() async {
    try {
      emit(MovieLoading());

      String collectionName =
          selectedStatus == 'Playing now' ? 'playing now films' : 'Movies';
      final movieData = await prepareMovieData();

      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(movieNameController.text)
          .set(movieData);

      emit(MovieSuccess());
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> addMovieToCinema() async {
    var cinemaId = LocalStorageService.getUserData()!;
    try {
      emit(MovieLoading());

      final cinemaRef = FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(extractUsername(cinemaId));

      final docSnapshot = await cinemaRef.get();

      if (!docSnapshot.exists) {
        AppLogs.errorLog("Cinema document does not exist.");
        emit(MovieError("Cinema document not found"));
        return;
      }

      Map<String, dynamic>? data = docSnapshot.data();
      List<dynamic> moviesList =
          data?['movies'] != null ? List.from(data!['movies']) : [];

      final movieData = await prepareMovieData();

      moviesList.add(movieData);

      await cinemaRef.update({'movies': moviesList});

      emit(MovieSuccess());
      ahmed.add(movieData);
    } catch (e) {
      AppLogs.errorLog("Error adding movie to cinema: $e");
      emit(MovieError(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserMovies() async {
    emit(MovieLoading());
    try {
      var cinemaId = extractUsername(LocalStorageService.getUserData()!);
      final DocumentReference cinemaRef =
          FirebaseFirestore.instance.collection('Cinemas').doc(cinemaId);
      final DocumentSnapshot docSnapshot = await cinemaRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey('movies') && data['movies'] is List) {
          final List<Map<String, dynamic>> movies =
              List<Map<String, dynamic>>.from(data['movies']);
          fetchedCinemaMovies = movies;

          emit(MovieFetched(fetchedCinemaMovies!));
          ahmed = movies;
          return movies;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      emit(MovieError(e.toString()));
      return [];
    }
  }

  Future<void> updateMovieInCinemaWithPreparedData(
      {required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
          child: Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: const Center(child: LoadingIndicator()),
        ),
      )),
    );

    var cinemaId = extractUsername(LocalStorageService.getUserData()!);

    try {
      final docRef =
          FirebaseFirestore.instance.collection('Cinemas').doc(cinemaId);
      final snapshot = await docRef.get();

      if (!snapshot.exists) throw Exception('Document not found');

      List<dynamic> movies = snapshot.data()?['movies'] ?? [];

      if (currentIndex! < 0 || currentIndex! >= movies.length) {
        throw Exception('Invalid index');
      }

      final newMovieData = await prepareMovieData();
      movies[currentIndex!] = newMovieData;

      await docRef.update({'movies': movies});
      ahmed = movies;
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Your data is updated successfully',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Something went wrong : $e',
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> updateMovieDocumentByName(
      {required BuildContext context}) async {
    String collectionName =
        selectedStatus == "Playing now" ? "playing now films" : "Movies";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: const Center(child: LoadingIndicator()),
        ),
      ),
    );

    try {
      final collectionRef =
          FirebaseFirestore.instance.collection(collectionName);
      final querySnapshot = await collectionRef
          .where('name', isEqualTo: movieNameController.text)
          .get();

      if (querySnapshot.docs.isEmpty) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sorry something went wrong',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red),
        );
        return;
      }

      final docId = querySnapshot.docs.first.id;
      final newMovieData = await prepareMovieData();

      await collectionRef.doc(docId).update(newMovieData);

      Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                    child: Text('Something went wrong : $e',
                        style: const TextStyle(color: Colors.white))),
              ],
            ),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> deleteMovieCompletely(
      {required BuildContext context, required int? movieIndex}) async {
    try {
      final String username =
          extractUsername(LocalStorageService.getUserData()!);
      DocumentReference cinemaDocRef =
          FirebaseFirestore.instance.collection('Cinemas').doc(username);

      DocumentSnapshot cinemaSnapshot = await cinemaDocRef.get();

      if (cinemaSnapshot.exists) {
        List<dynamic> movies = List.from(cinemaSnapshot['movies']);

        if (movieIndex! >= 0 && movieIndex < movies.length) {
          final movieData = movies[movieIndex];
          final String movieName = movieData['name'];
          final String status = movieData['status'];

          movies.removeAt(movieIndex);
          await cinemaDocRef.update({'movies': movies});

          final targetCollection =
              (status == 'Playing now') ? 'playing now films' : 'Movies';

          QuerySnapshot targetSnapshot = await FirebaseFirestore.instance
              .collection(targetCollection)
              .get();

          for (QueryDocumentSnapshot doc in targetSnapshot.docs) {
            if (doc['name'] == movieName) {
              await FirebaseFirestore.instance
                  .collection(targetCollection)
                  .doc(doc.id)
                  .delete();
              break;
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Movie deleted successfully',
                    style: TextStyle(color: Colors.white)),
                duration: Duration(seconds: 2)),
          );
        } else {
          print('Invalid movie index');
        }
      } else {
        print('Cinema document not found');
      }
    } catch (e) {
      print('Error deleting movie: $e');
    }
  }
}
