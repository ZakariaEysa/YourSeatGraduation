import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/local_storage_service/local_storage_service.dart';
import '../../../../../utils/app_logs.dart';
import '../../data/model/ticket_details_model.dart';
import '../../domain/repos/payment_repo.dart';

part 'ticket_details_state.dart';

class TicketDetailsCubit extends Cubit<TicketDetailsState> {
  TicketDetailsCubit(this.ticketDetailsRepo) : super(TicketDetailsInitial());
  static TicketDetailsCubit get(context) =>
      BlocProvider.of<TicketDetailsCubit>(context);

  final TicketDetailsRepo ticketDetailsRepo;
  final TextEditingController ticketController = TextEditingController();

  String? cinemaId;
  Ticket ticket = const Ticket(
    category: "",
    date: "",
    duration: "",
    hall: "",
    movieName: "",
    posterImage: "",
    seatCategory: "",
    seats: [],
    status: "",
    time: "",
    totalPrice: 0,
    userEmail: "",
    orderId: "",
  );
  Future<void> findAndPrintTicket({required String orderId}) async {
    cinemaId = extractUsername(LocalStorageService.getUserData() ?? "");

    emit(TicketDetailsLoading());

    final result = await ticketDetailsRepo.findAndPrintTicket(
        cinemaId: cinemaId ?? "", orderId: orderId);
    result.fold((failure) => emit(TicketDetailsError(failure.errorMsg)),
        (ticketS) {
      ticket = ticketS ??
          const Ticket(
            category: "",
            date: "",
            duration: "",
            hall: "",
            movieName: "",
            posterImage: "",
            seatCategory: "",
            seats: [],
            status: "",
            time: "",
            totalPrice: 0,
            userEmail: "",
            orderId: "",
          );

      emit(TicketDetailsSuccess(ticketS!));
    });
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
