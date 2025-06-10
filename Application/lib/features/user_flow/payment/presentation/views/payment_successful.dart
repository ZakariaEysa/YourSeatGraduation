import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../my_tikect/presentation/view/ticket_done.dart';
import '../../../../../utils/navigation.dart';
import '../../../../../widgets/scaffold/scaffold_f.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/button/button_builder.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful(
      {super.key,
      required this.model,
      required this.seats,
      required this.seatCategory,
      required this.price,
      required this.location,
      required this.date,
      required this.time,
      required this.cinemaId,
      required this.hall,
      required this.orderId});

  final String orderId;
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
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 150.h),
          child: Image.asset(
            "assets/images/check .png",
            width: 209.w,
            height: 209.h,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        SizedBox(
          height: 31.h,
        ),
        Text(
          lang.paymentSuccessful,
          style: theme.textTheme.labelLarge!.copyWith(fontSize: 36.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 52.h,
        ),
        ButtonBuilder(
          text: lang.ticket,
          onTap: () {
            navigateAndReplace(
                context: context,
                screen: TicketDone(
                  status: "Active",
                  orderId: orderId,
                  hall: hall,
                  model: model,
                  seatCategory: seatCategory,
                  seats: seats,
                  price: price,
                  location: location,
                  date: date,
                  time: time,
                  cinemaId: cinemaId,
                ));
          },
          width: 173.w,
          height: 50.h,
        )
      ],
    ));
  }
}
