import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/network_image/image_replacer.dart';

class HeadMyTicket extends StatelessWidget {
  String? imageUrl;
  String? movieName;
  String? movieDuration;
  String? movieCategory;
  String? seatCategory;
  String? movieTime;
  String? movieDate;
  List<String>? seats;
  String? hall;

  HeadMyTicket({
    required this.imageUrl,
    required this.movieName,
    required this.movieDuration,
    required this.movieCategory,
    required this.seatCategory,
    required this.movieTime,
    required this.movieDate,
    required this.seats,
    required this.hall,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // التأكد من أن القائمة ليست فارغة
    List<String> firstRowSeats = seats != null ? seats!.take(3).toList() : [];
    List<String> secondRowSeats =
        seats != null && seats!.length > 3 ? seats!.skip(3).toList() : [];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 10.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: ImageReplacer(
                    imageUrl: imageUrl ?? "",
                    width: 100.w,
                    height: 160.h,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 18.w,
                        top: 30.h,
                        left: 18.w,
                      ),
                      child: Text(
                        seatCategory ?? "",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA79F06),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text(
                          movieName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/clock_icon.png",
                          width: 16.w,
                          height: 18.h,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            movieDuration ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/video.png",
                          width: 16.w,
                          height: 18.h,
                          color: Colors.black,
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            movieCategory ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/calendar.png',
                    width: 45.w,
                    height: 45.h,
                  ),
                  SizedBox(width: 2.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieTime ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      Text(
                        movieDate ?? "",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/vYzyIu_2_.png',
                    width: 45.w,
                    height: 45.h,
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // السطر الأول من المقاعد
                      Wrap(
                        spacing: 5.w, // تباعد أفقي بين المقاعد
                        children: firstRowSeats
                            .map((seat) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    seat,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                ))
                            .toList(),
                      ),
                      SizedBox(height: 5.h), // تباعد بين السطرين

                      // السطر الثاني من المقاعد (إذا كان هناك مقاعد إضافية)
                      Wrap(
                        spacing: 5.w,
                        children: secondRowSeats
                            .map((seat) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    seat,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                ))
                            .toList(),
                      ),

                      SizedBox(height: 5.h),
                      Text(
                        "Section ${hall ?? ''}",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
