import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/dialog_utilits.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../cubit/payment_cubit.dart';
import 'payment_test.dart';
import '../../../../../widgets/loading_indicator.dart';
import '../widgets/payment_part.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';

import '../../../../../generated/l10n.dart';

class Payment extends StatelessWidget {
  const Payment(
      {super.key,
      required this.model,
      required this.seatCategory,
      required this.seats,
      required this.price,
      required this.location,
      required this.date,
      required this.time,
      required this.cinemaId,
      required this.hall});
  final MoviesDetailsModel model;
  final List<String> seats;
  final String seatCategory;
  final String hall;

  final num price;
  final String location;
  final String date;
  final String time;
  final String cinemaId;

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return ScaffoldF(
        appBar: AppBar(
          title: Text(
            lang.payment,
            style: theme.textTheme.labelLarge!.copyWith(fontSize: 24.sp),
          ),
          titleSpacing: 80.0,
          leading: IconButton(
              onPressed: () {
                navigatePop(context: context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 26.sp,
              )),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    PaymentPart(
                      date: date,
                      time: time,
                      location: location,
                      model: model,
                      seats: seats,
                      total: '$price EGP',
                      title: lang.paymentMethod,
                    ),
                    Container(
                      width: 292.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Color(0xFF382076).withOpacity(.90),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/card.png",
                                width: 40.41.w,
                                height: 35.83.h,
                              ),
                              Spacer(),
                              Text(
                                lang.payWithCard,
                                style: theme.textTheme.titleLarge!
                                    .copyWith(fontSize: 16.sp),
                              ),
                              Spacer(),
                              BlocListener<PaymentCubit, PaymentState>(
                                listener: (context, state) {
                                  // AppLogs.errorLog(state.toString()); // Removed: was used for logging payment state
                                  // AppLogs.errorLog(state.payToken.toString()); // Removed: was used for logging payment token
                                  // AppLogs.debugLog("order id is "); // Removed: was used for logging order id
                                  // AppLogs.successLog(PaymentCubit.get(context).orderIdForPaymentTicket); // Removed: was used for logging order id for payment ticket
                                  if (state is PaymentSuccess) {
                                    // AppLogs.errorLog(state.payToken.toString()); // Removed: was used for logging payment token
                                    // AppLogs.debugLog("order id is "); // Removed: was used for logging order id
                                    // AppLogs.successLog(PaymentCubit.get(context).orderIdForPaymentTicket); // Removed: was used for logging order id for payment ticket

                                    navigateTo(
                                        context: context,
                                        screen: PaymentScreen(
                                            orderId: PaymentCubit.get(context)
                                                .orderIdForPaymentTicket,
                                            hall: hall,
                                            model: model,
                                            seatCategory: seatCategory,
                                            seats: seats,
                                            price: price,
                                            location: location,
                                            date: date,
                                            time: time,
                                            cinemaId: cinemaId,
                                            paymentToken:
                                                state.payToken ?? ""));
                                  } else if (state is PaymentError) {
                                    // AppLogs.errorLog(state.error.toString()); // Removed: was used for logging payment error
                                    showCenteredSnackBar(context,
                                        "Something went wrong please try again and check your connection");
                                  }
                                },
                                child: IconButton(
                                    onPressed: () async {
                                      // AppLogs.debugLog(date.toString()); // Removed: was used for logging date
                                      // AppLogs.debugLog(time.toString()); // Removed: was used for logging time
                                      // AppLogs.debugLog(seats.toString()); // Removed: was used for logging seats
                                      bool canProceed =
                                          await checkSeatsAvailability(
                                        selectedSeats: seats,
                                        cinemaName: cinemaId,
                                        movieName: model.name.toString(),
                                        date: date.toString(),
                                        time: time,
                                      );

                                      if (!canProceed) {
                                        showCenteredSnackBar(context,
                                            "some seats are not available");
                                        return;
                                      }

                                      PaymentCubit.get(context)
                                          .payWithPayMobToGetOrderId(price);

                                      // PayMobPayment().refundPayment(
                                      //     transactionId: "266671705", amount: 100);

                                      // PayMobPayment().getAllTransactions();

                                      // PayMobPayment().payWithPayMob(100).then(

                                      //   (value) {
                                      //     AppLogs.successLog(
                                      //         "payment token: $value");
                                      //     navigateTo(
                                      //         context: context,
                                      //         screen: PaymentScreen(
                                      //             paymentToken: value ?? ""));
                                      //   },
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.white,
                                      size: 20.sp,
                                    )),
                              ),
                              //   color: Colors.white,

                              SizedBox(
                                width: 2.w,
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: 292.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Color(0xFF382076).withOpacity(.90),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/payy.png",
                                width: 30.w,
                                height: 31.h,
                              ),
                              Spacer(),
                              Text(
                                lang.instapay,
                                style: theme.textTheme.titleLarge!
                                    .copyWith(fontSize: 16.sp),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    showCenteredSnackBar(context,
                                        "This feature is not available yet");
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                    size: 20.sp,
                                  )),
                              //   color: Colors.white,

                              SizedBox(
                                width: 1.w,
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    // Container(
                    //   width: 238.w,
                    //   height: 38.h,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: Color(0xFF31215B),
                    //     border: Border.all(
                    //       color: Color(0xFF673667),
                    //       width: 2.w,
                    //     ),
                    //   ),
                    //   // child: Padding(
                    //   //   padding: EdgeInsets.all(8.sp),
                    //   //   child: Row(
                    //   //     children: [
                    //   //       Text(
                    //   //         " ${lang.completeYourPaymentIn}",
                    //   //         style: theme.textTheme.titleLarge!
                    //   //             .copyWith(fontSize: 11.sp),
                    //   //       ),
                    //   //       Spacer(),
                    //   //       Text(
                    //   //         "15:00  ",
                    //   //         style: theme.textTheme.titleLarge!.copyWith(
                    //   //             fontSize: 11.sp, color: Color(0xFFC11E88)),
                    //   //       ),
                    //   //     ],
                    //   //   ),
                    //   // ),
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const AbsorbPointer(
                    absorbing: true,
                    child: LoadingIndicator(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ));
  }

  Future<bool> checkSeatsAvailability({
    required List<String> selectedSeats,
    required String cinemaName,
    required String movieName,
    required String date,
    required String time,
  }) async {
    try {
      // 🔹 جلب بيانات السينما
      DocumentSnapshot cinemaSnapshot = await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(cinemaName)
          .get();

      if (!cinemaSnapshot.exists) {
        // print("⚠️ السينما غير موجودة: $cinemaName");
        return false; // السينما غير موجودة، لا يمكن الحجز
      }

      Map<String, dynamic>? cinemaData =
          cinemaSnapshot.data() as Map<String, dynamic>?;
      if (cinemaData == null || !cinemaData.containsKey('movies')) {
        // print("⚠️ لا يوجد أفلام في هذه السينما.");
        return false;
      }

      // 🔹 البحث عن الفيلم
      List<dynamic> moviesList = List.from(cinemaData['movies']);
      var selectedMovie = moviesList.firstWhere(
        (movie) => movie['name'] == movieName,
        orElse: () => <String, dynamic>{},
      );

      if (selectedMovie.isEmpty) {
        // print("⚠️ الفيلم غير موجود في السينما: $movieName");
        return false;
      }

      // 🔹 البحث عن اليوم داخل الفيلم
      List<dynamic> timesList = List.from(selectedMovie['times']);
      var selectedDay = timesList.firstWhere(
        (e) => e['date'] == date,
        orElse: () => <String, dynamic>{},
      );

      if (selectedDay.isEmpty) {
        // print("⚠️ لا يوجد عرض لهذا الفيلم في هذا اليوم: $date");
        return false;
      }

      // 🔹 البحث عن الوقت داخل اليوم
      List<dynamic> times = List.from(selectedDay['time']);
      var selectedTime = times.firstWhere(
        (e) => e['time'] == time,
        orElse: () => <String, dynamic>{},
      );

      if (selectedTime.isEmpty) {
        // print("⚠️ لا يوجد عرض في هذا الوقت: $time");
        return false;
      }

      // 🔹 جلب المقاعد المحجوزة من الوقت المحدد
      List<String> reservedSeats =
          List<String>.from(selectedTime["reservedSeats"] ?? []);

      // 🔹 مقارنة المقاعد المختارة بالمقاعد المحجوزة
      bool isAnySeatReserved =
          selectedSeats.any((seat) => reservedSeats.contains(seat));

      if (isAnySeatReserved) {
        // print(
        //     "❌ بعض المقاعد محجوزة بالفعل: ${selectedSeats.where((seat) => reservedSeats.contains(seat)).toList()}");
        return false; // ❌ يوجد مقاعد محجوزة، لا يمكن إتمام الحجز
      }

      // print("✅ المقاعد متاحة للحجز!");
      return true; // ✅ يمكن إتمام الحجز
    } catch (e) {
      // print("❌ خطأ أثناء التحقق من توفر المقاعد: $e");
      return false;
    }
  }
}
