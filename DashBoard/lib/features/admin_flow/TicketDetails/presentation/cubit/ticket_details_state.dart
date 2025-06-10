part of 'ticket_details_cubit.dart';

sealed class TicketDetailsState extends Equatable {
  const TicketDetailsState();

  @override
  List<Object> get props => [];
}

final class TicketDetailsInitial extends TicketDetailsState {}

final class TicketDetailsLoading extends TicketDetailsState {}

final class TicketDetailsSuccess extends TicketDetailsState {
  final Ticket ticket;
  const TicketDetailsSuccess(this.ticket);
}

final class TicketDetailsError extends TicketDetailsState {
  final String errorMsg;
  const TicketDetailsError(this.errorMsg);
}
