import 'package:dartz/dartz.dart';
import '../../../../../services/failure_service.dart';
import '../../data/model/ticket_details_model.dart';

abstract class TicketDetailsRepo {
  Future<Either<FailureService, Ticket?>> findAndPrintTicket({
    required String cinemaId,
    required String orderId,
  });
}
