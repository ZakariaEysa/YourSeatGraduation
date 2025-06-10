import 'package:dartz/dartz.dart';
import '../../../../../services/failure_service.dart';
import '../../domain/repos/payment_repo.dart';
import '../model/ticket_details_model.dart';
import '../remote_data_source/ticket_details_remote_data_source.dart';

class TicketDetailsRepoImpl implements TicketDetailsRepo {
  final TicketDetailsRemoteDataSource remoteDataSource;

  TicketDetailsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<FailureService, Ticket>> findAndPrintTicket({
    required String cinemaId,
    required String orderId,
  }) async {
    try {
      final ticket = await remoteDataSource.findAndPrintTicket(
        cinemaId: cinemaId,
        orderId: orderId,
      );

      if (ticket == null) {
        return Left(ServiceFailure('Ticket not found.'));
      }

      return Right(ticket);
    } catch (e) {
      return Left(ServiceFailure(e.toString()));
    }
  }
}
