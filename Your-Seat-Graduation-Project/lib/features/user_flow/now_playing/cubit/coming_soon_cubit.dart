import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'coming_soon_state.dart';

class ComingSoonCubit extends Cubit<ComingSoonState> {
  ComingSoonCubit() : super(ComingSoonInitial());

  Future<void> fetchComingMovies() async {
    try {
      emit(ComingSoonLoading());
      final snapshot =
          await FirebaseFirestore.instance.collection('Movies').get();
      final movies = snapshot.docs.map((doc) => doc.data()).toList();
      emit(ComingSoonLoaded(movies));
    } catch (e) {
      emit(ComingSoonError("Error fetching coming soon movies: $e"));
    }
  }
}
