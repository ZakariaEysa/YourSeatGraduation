// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/models/crew_model.dart';
// import 'package:yourseatgraduationproject/features/admin_flow/moives/data/models/movies_model.dart';
//
//
// class MovieState {
//   final MoviesDetailsModel movie;
//   final bool loading;
//   final bool success;
//   final String? error;
//
//   MovieState({
//     MoviesDetailsModel? movie,
//     this.loading = false,
//     this.success = false,
//     this.error,
//   }) : movie = movie ?? const MoviesDetailsModel(
//
//     crewImages: {},
//       name: '',
//       duration: '',
//       language: '',
//       category: '',
//       status: '',
//       censorship: '',
//       ageRating: '',
//       description: '',
//       releaseDate: '',
//       rating: 0.0,
//       trailer: '',
//       posterImage: '',
//       cast: [],
//       castImages: [],
//       crew: Crew()
//   );
//
//   MovieState copyWith({
//     MoviesDetailsModel? movie,
//     bool? loading,
//     bool? success,
//     String? error,
//   }) {
//     return MovieState(
//       movie: movie ?? this.movie,
//       loading: loading ?? this.loading,
//       success: success ?? this.success,
//       error: error ?? this.error,
//     );
//   }
//
// }

// movie_state.dart
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}

class MovieImagePicked extends MovieState {}

class MoviePromoUpdated extends MovieState {}

class MovieCrewImagePicked extends MovieState {}

class MovieActorAdded extends MovieState {}

class MovieFetched extends MovieState {
  final List<Map<String, dynamic>> movies;
  MovieFetched(this.movies);
}

class MovieUpdatedInCinema extends MovieState {}

class MovieUpdatedInFirestore extends MovieState {}

class MovieDeletedCompletely extends MovieState {}

class MovieDeleting extends MovieState {}

class MovieIndexSet extends MovieState {
  final int index;
  MovieIndexSet(this.index);
}
