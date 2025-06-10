import 'package:equatable/equatable.dart';

abstract class CinemaItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class CinemaLoading extends CinemaItemState {}

class CinemaSuccess extends CinemaItemState {
  final List<Map<String, dynamic>> cinemas;

  CinemaSuccess(this.cinemas);

  @override
  List<Object> get props => [cinemas];
}

class CinemaFailure extends CinemaItemState {
  final String error;

  CinemaFailure(this.error);

  @override
  List<Object> get props => [error];
}
