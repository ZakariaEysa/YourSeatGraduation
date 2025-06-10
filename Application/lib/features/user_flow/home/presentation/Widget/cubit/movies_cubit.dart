import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'movies_state.dart';

class MovieCarouselCubit extends Cubit<MovieCarouselState> {
  MovieCarouselCubit() : super(MovieCarouselInitial());

  Future<void> fetchMovies() async {
    try {
      emit(MovieCarouselLoading());
      final snapshot = await FirebaseFirestore.instance
          .collection('playing now films')
          .get();
      final movies = snapshot.docs.map((doc) => doc.data()).toList();
      emit(MovieCarouselLoaded(movies));
    } catch (e) {
      emit(MovieCarouselError("Error fetching movies: $e"));
    }
  }
}
