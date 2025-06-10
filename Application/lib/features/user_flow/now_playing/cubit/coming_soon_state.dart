import 'package:equatable/equatable.dart';

abstract class ComingSoonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ComingSoonLoading extends ComingSoonState {}

class ComingSoonInitial extends ComingSoonState {}

class ComingSoonLoaded extends ComingSoonState {
  final List<Map<String, dynamic>> movies;

  ComingSoonLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class ComingSoonError extends ComingSoonState {
  final String message;

  ComingSoonError(this.message);

  @override
  List<Object?> get props => [message];
}
