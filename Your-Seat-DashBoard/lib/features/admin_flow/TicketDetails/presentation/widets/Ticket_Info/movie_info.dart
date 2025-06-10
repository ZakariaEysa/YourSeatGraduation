import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/TicketDetails/presentation/widets/Ticket_Info/dynamic_images.dart';

import '../../../data/model/ticket_details_model.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({super.key, required this.ticket});
  final Ticket ticket;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DynamicImage(imageSource: ticket.posterImage),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              ticket.movieName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icons/clock_icon.png",
                  width: 5.w,
                  height: 20.h,
                  color: Colors.black,
                ),
                SizedBox(width: 2.w),
                Text(
                  ticket.duration,
                  style: TextStyle(color: Colors.black, fontSize: 4.sp),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/video.png",
                  width: 5.w,
                  height: 20.h,
                  color: Colors.black,
                ),
                SizedBox(width: 2.w),
                Text(
                  ticket.category,
                  style: TextStyle(color: Colors.black, fontSize: 4.sp),
                )
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/calendar.png",
                      width: 10.w,
                      height: 48.h,
                      color: Colors.black,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "${ticket.time} \n ${ticket.date}",
                      style: TextStyle(color: Colors.black, fontSize: 4.sp),
                    )
                  ],
                ),
                SizedBox(width: 10.w),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/vYzyIu_2_.png",
                      width: 10.w,
                      height: 48.h,
                      color: Colors.black,
                    ),
                    SizedBox(width: 2.w),
                    ...ticket.seats.map((seat) => Text(
                          "$seat \n",
                          style: TextStyle(color: Colors.black, fontSize: 4.sp),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
