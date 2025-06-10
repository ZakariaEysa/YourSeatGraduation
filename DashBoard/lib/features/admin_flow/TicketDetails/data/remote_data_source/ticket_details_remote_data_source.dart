import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../utils/app_logs.dart';
import '../model/ticket_details_model.dart';

abstract class TicketDetailsRemoteDataSource {
  Future<Ticket?> findAndPrintTicket({
    required String cinemaId,
    required String orderId,
  });
}

class TicketDetailsRemoteDataSourceImpl
    implements TicketDetailsRemoteDataSource {
  @override
  Future<Ticket?> findAndPrintTicket({
    required String cinemaId,
    required String orderId,
  }) async {
    try {
      if (orderId.contains("#")) {
        orderId = orderId.replaceAll("#", "");
      }
      // findAndPrintTicket(cinemaId: "Plaza Cinema", orderId: "304514032");

      final cinemaDoc = await FirebaseFirestore.instance
          .collection("Cinemas")
          .doc(cinemaId)
          .get();

      if (!cinemaDoc.exists) {
        AppLogs.errorLog('Cinema with ID [$cinemaId] not found.');
        return null;
      }

      final data = cinemaDoc.data();
      if (data == null || !data.containsKey('tickets')) {
        AppLogs.errorLog('No tickets found for cinema [$cinemaId].');
        return null;
      }

      final List<dynamic> tickets = data['tickets'];

      final ticketMap = tickets.cast<Map<String, dynamic>>().firstWhere(
            (ticket) => ticket['orderId'].toString() == orderId,
            orElse: () => {},
          );

      if (ticketMap.isEmpty) {
        AppLogs.errorLog('No ticket found with orderId [$orderId].');
        return null;
      }

      final ticket = Ticket.fromMap(ticketMap);
      AppLogs.scussessLog('Ticket found: $ticket');
      return ticket;
    } catch (e, stackTrace) {
      AppLogs.errorLog('Error finding ticket: $e');
      AppLogs.errorLog(stackTrace.toString());
      return null;
    }
  }
}
