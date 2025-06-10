import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

import '../../../../data/local_storage_service/local_storage_service.dart';
import '../models/ticket_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  List<TicketModel> ticketsList = [];
  String? cinemaName;

  Future<void> getCinemaTickets() async {
    cinemaName = extractUsername(LocalStorageService.getUserData() ?? "");

    emit(TicketsStatesLoading());
    try {
      final firestore = FirebaseFirestore.instance;

      print('📍 Trying to access cinema: $cinemaName');

      final cinemaRef = firestore.collection('Cinemas').doc(cinemaName);

      final cinemaDoc = await cinemaRef.get();

      if (!cinemaDoc.exists) {
        print('❌ Cinema document "$cinemaName" does not exist.');
        throw Exception('Cinema document does not exist.');
      }

      print('✅ Cinema document found. Extracting tickets list...');

      final data = cinemaDoc.data();
      if (data == null || !data.containsKey('tickets')) {
        print('⚠️ No "tickets" field found in the cinema document.');
        throw Exception('No tickets yet .');
      }

      final rawTickets = data['tickets'];

      if (rawTickets is! List) {
        print('❌ "tickets" field is not a list.');
        throw Exception('Tickets field is not a list.');
      }

      print('🎟️ ${rawTickets.length} tickets found.');

      final tickets = rawTickets
          .map<TicketModel>((ticket) => TicketModel.fromMap(ticket))
          .toList();

      // Logging for confirmation
      AppLogs.scussessLog(tickets.length.toString());
      AppLogs.scussessLog(tickets[0].toMap().toString());

      ticketsList = tickets;
      emit(TicketsStatesSuccess(tickets));

      // return tickets;
    } catch (e, stackTrace) {
      print('🔥 Exception occurred: $e');
      print('📌 StackTrace:\n$stackTrace');

      emit(TicketsStatesError(e.toString()));
    }
  }

  String extractUsername(String email) {
    AppLogs.errorLog(email.toString());

    // نفترض إن الإيميل دايماً بينتهي بـ @admin.com
    if (email.contains("@")) {
      // بنشيل الجزء بتاع @admin.com ونرجع الاسم
      return email.substring(0, email.indexOf("@admin.com"));
    } else {
      return "Invalid email format"; // لو الإيميل مش بالصيغة المطلوبة
    }
  }
}
