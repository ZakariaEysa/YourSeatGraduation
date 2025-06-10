part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class TicketsStatesLoading extends HomeState {}

final class TicketsStatesSuccess extends HomeState {
  final List<TicketModel> tickets;
  const TicketsStatesSuccess(this.tickets);
}

final class TicketsStatesError extends HomeState {
  final String errorMsg;
  const TicketsStatesError(this.errorMsg);
}
