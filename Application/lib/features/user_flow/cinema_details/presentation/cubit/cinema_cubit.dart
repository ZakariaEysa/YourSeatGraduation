import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/hive_keys.dart';
import '../../../../../data/hive_storage.dart';
import '../../../../../utils/dialog_utilits.dart';
import '../../../../../utils/navigation.dart';
import '../../../auth/presentation/views/sign_in.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import 'cinema_state.dart';

class CinemaCubit extends Cubit<CinemaState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController commentController = TextEditingController();
  var currentUser;
  bool isAddingComment = false; // ✅ متغير لمنع الإرسال المتكرر

  Map<String, dynamic> cinemaDataMap = {};
  List<MoviesDetailsModel> moviesList = [];
  List<Map<String, dynamic>> commentsList = [];
  List<MoviesDetailsModel> moviesDataList = [];
  List<Map<String, dynamic>> allComments = []; // ✅ جميع التعليقات المحملة

  List<Map<String, dynamic>> comments = [];

  CinemaCubit() : super(CinemaInitial());

  static CinemaCubit get(BuildContext context) =>
      BlocProvider.of<CinemaCubit>(context);

  TextEditingController get getCommentController => commentController;

  Future<void> fetchCinemaDetails(String cinemaId) async {
    try {
      emit(CinemaLoading());
      DocumentSnapshot snapshot =
          await _firestore.collection('Cinemas').doc(cinemaId).get();

      if (snapshot.exists) {
        Map<String, dynamic> cinemaData =
            snapshot.data() as Map<String, dynamic>;
        List<MoviesDetailsModel> movies = await fetchMoviesByCinema(cinemaId);
        cinemaDataMap = cinemaData;
        moviesList = movies;
        emit(
            CinemaLoaded(cinemaData: cinemaData, comments: [], movies: movies));
      } else {
        emit(CinemaError("No cinema details found"));
      }
    } catch (e) {
      emit(CinemaError("Error fetching cinema details: $e"));
    }
  }

  Future<List<MoviesDetailsModel>> fetchMoviesByCinema(String cinemaId) async {
    try {
      emit(CinemaMoviesLoading());
      final snapshot =
          await _firestore.collection('Cinemas').doc(cinemaId).get();

      if (snapshot.exists) {
        var cinemaData = snapshot.data();
        var movies = cinemaData?['movies'] as List? ?? [];
        List<MoviesDetailsModel> moviesList = movies
            .map((movie) =>
                MoviesDetailsModel.fromJson(movie as Map<String, dynamic>))
            .toList();
        moviesDataList = moviesList;
        emit(CinemaMoviesLoaded(moviesList));
        return moviesList;
      } else {
        emit(CinemaMoviesError("No movies found"));
        return [];
      }
    } catch (e) {
      emit(CinemaMoviesError("Error fetching movies: $e"));
      return [];
    }
  }

  Future<void> fetchCinemaComments(String cinemaId) async {
    try {
      // AppLogs.debugLog("Fetching comments for cinema: $cinemaId");
      emit(CinemaCommentsLoading());

      final snapshot = await _firestore
          .collection('Cinemas')
          .doc(cinemaId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .get();
      // AppLogs.debugLog("Comments fetched: ${snapshot.docs.length}");
      allComments = snapshot.docs.map((doc) => doc.data()).toList();
      if (allComments.length > 5) {
        commentsList = allComments.take(5).toList();
      } else {
        commentsList = allComments;
      }

      // AppLogs.debugLog("Comments done");
      comments = commentsList;
      emit(CinemaCommentsLoaded());
      emit(CinemaControllerToBottom());
    } catch (e) {
      emit(CinemaCommentsError("Error fetching comments: $e"));
    }
  }

  void loadMoreComments() {
    final currentLength = commentsList.length;
    final remainingComments = allComments.length - currentLength;
    if (remainingComments > 0) {
      final nextBatch = allComments.skip(currentLength).take(5).toList();
      commentsList.addAll(nextBatch);
      comments = commentsList;
      // AppLogs.debugLog("Comments loaded more");
      emit(CinemaCommentsLoaded());
      emit(CinemaControllerToBottom());
    }
  }

  Future<void> addComment(
    String cinemaId,
    BuildContext context,
    String signInText,
    String cancelText,
    TextEditingController getCommentController,
  ) async {
    if (isAddingComment) return;
    isAddingComment = true;
    emit(CinemaCommentsLoading());

    if (HiveStorage.get(HiveKeys.role) == Role.guest.toString()) {
      DialogUtils.showMessage(
        context,
        "You Have To Sign In To Continue",
        isCancelable: false,
        posActionTitle: signInText,
        negActionTitle: cancelText,
        posAction: () {
          HiveStorage.set(HiveKeys.role, "");
          navigateAndRemoveUntil(context: context, screen: const SignIn());
        },
        negAction: () => navigatePop(context: context),
      );
      isAddingComment = false;
      return;
    }

    currentUser = HiveStorage.get(HiveKeys.role) == Role.google.toString()
        ? HiveStorage.getGoogleUser()
        : HiveStorage.getDefaultUser();

    if (commentController.text.isNotEmpty) {
      try {
        // ✅ إضافة التعليق الجديد
        await _firestore
            .collection('Cinemas')
            .doc(cinemaId)
            .collection('comments')
            .add({
          'text': commentController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'userName': currentUser.name,
          'image': currentUser.image,
        });

        comments.add({
          'text': commentController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'userName': currentUser.name,
          'image': currentUser.image,
        });
        commentController.clear();
        emit(CinemaCommentsLoaded());
        emit(CinemaControllerToBottom());

        // ✅ تحديث جميع التعليقات السابقة بالاسم الجديد
        // await _updateOldComments(cinemaId, currentUser.name, currentUser.image);

        // await fetchCinemaComments(cinemaId);
      } catch (e) {
        emit(CinemaCommentsError("Error adding comment: $e"));
      }
    }
    isAddingComment = false;
  }

  // Future<void> _updateOldComments(
  //     String cinemaId, String newName, String newImage) async {
  //   try {
  //     // ✅ جلب كل تعليقات المستخدم الحالي
  //     final snapshot = await _firestore
  //         .collection('Cinemas')
  //         .doc(cinemaId)
  //         .collection('comments')
  //         .where('userName', isEqualTo: currentUser.name) // البحث بالاسم القديم
  //         .get();

  //     // ✅ تحديث كل تعليق بالاسم والصورة الجديدة
  //     for (var doc in snapshot.docs) {
  //       await _firestore
  //           .collection('Cinemas')
  //           .doc(cinemaId)
  //           .collection('comments')
  //           .doc(doc.id)
  //           .update({
  //         'userName': newName,
  //         'image': newImage,
  //       });
  //     }

  //     AppLogs.debugLog("Updated all old comments with new name: $newName");
  //   } catch (e) {
  //     AppLogs.errorLog("Error updating old comments: $e");
  //   }
  // }
}
