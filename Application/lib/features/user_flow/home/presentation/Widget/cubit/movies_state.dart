import 'package:equatable/equatable.dart';

abstract class MovieCarouselState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieCarouselInitial extends MovieCarouselState {}
class MovieCarouselLoading extends MovieCarouselState {}

class MovieCarouselLoaded extends MovieCarouselState {
  final List<Map<String, dynamic>> movies;

  MovieCarouselLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieCarouselError extends MovieCarouselState {
  final String message;

  MovieCarouselError(this.message);

  @override
  List<Object?> get props => [message];
}
