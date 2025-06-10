import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';

abstract class CinemaState {}

class CinemaInitial extends CinemaState {}

class CinemaLoading extends CinemaState {}

class CinemaLoaded extends CinemaState {
  final Map<String, dynamic> cinemaData;
  final List<Map<String, dynamic>> comments;
  final List<MoviesDetailsModel> movies;

  CinemaLoaded({
    required this.cinemaData,
    required this.comments,
    required this.movies,
  });
}

class CinemaError extends CinemaState {
  final String message;
  CinemaError(this.message);
}

class CinemaCommentsLoading extends CinemaState {} // ✅ حالة تحميل التعليقات

class CinemaCommentsLoaded extends CinemaState {
  CinemaCommentsLoaded();
}

class CinemaControllerToBottom extends CinemaState {
  CinemaControllerToBottom();
}

class CinemaCommentsError extends CinemaState {
  // ✅ حالة خطأ عند تحميل التعليقات
  final String message;
  CinemaCommentsError(this.message);
}

class CinemaMoviesInitial extends CinemaState {}

class CinemaMoviesLoading extends CinemaState {}

class CinemaMoviesLoaded extends CinemaState {
  final List<MoviesDetailsModel> movies;
  CinemaMoviesLoaded(this.movies);
}

class CinemaMoviesError extends CinemaState {
  final String message;
  CinemaMoviesError(this.message);
}
