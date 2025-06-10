part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsSuccess extends MovieDetailsState {
  final String message;
  MovieDetailsSuccess(this.message);
}

final class MovieDetailsError extends MovieDetailsState {
  final String error;
  MovieDetailsError(this.error);
}

final class GetCinemasLoading extends MovieDetailsState {}

final class GetCinemasSuccess extends MovieDetailsState {
  final List cinemas;
  GetCinemasSuccess(this.cinemas);
}

final class GetCinemasError extends MovieDetailsState {
  final String error;
  GetCinemasError(this.error);
}

final class GetRateLoading extends MovieDetailsState {}

final class GetRateSuccess extends MovieDetailsState {
  final String rate;
  GetRateSuccess(this.rate);
}

final class GetRateError extends MovieDetailsState {
  final String error;
  GetRateError(this.error);
}
