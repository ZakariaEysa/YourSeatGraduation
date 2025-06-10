import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../movie_details/data/model/movies_details_model/movies_details_model.dart';
import '../../../../../widgets/network_image/image_replacer.dart';

import '../../../../../generated/l10n.dart';

class PaymentPart extends StatelessWidget {
  final String total;
  final String title;
  final String location;
  final String date;
  final String time;
  final MoviesDetailsModel model;
  final List seats;
  const PaymentPart(
      {super.key,
      required this.total,
      required this.title,
      required this.model,
      required this.seats,
      required this.location,
      required this.date,
      required this.time});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return Column(children: [
      Container(
        width: 350.w,
        height: 273.h,
        decoration: BoxDecoration(
            color: Color(0xFF3B2082).withOpacity(.90),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 335.w,
              height: 141.h,
              decoration: BoxDecoration(
                  color: Color(0xFF382076).withOpacity(.90),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: ImageReplacer(
                      imageUrl: model.posterImage.toString(),
                      width: 95.w,
                      height: 105.h,
                    ),
                  ),
                  SizedBox(width: 9.w),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name.toString(),
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontSize: 19.sp, color: Colors.yellow),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/video-play.png",
                              width: 16.w,
                              height: 16.h,
                              color: Color(0xFFE6E6E6),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              model.category.toString(),
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp, color: Color(0xFFE6E6E6)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/location1.png",
                              width: 16.w,
                              height: 16.h,
                              color: Color(0xFFE6E6E6),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              location.toString(),
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp, color: Color(0xFFE6E6E6)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/icons/clock.png",
                              width: 16.w,
                              height: 16.h,
                              color: Color(0xFFE6E6E6),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              "$date • $time",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp, color: Color(0xFFE6E6E6)),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lang.seat,
                    style:
                        theme.textTheme.titleLarge!.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ...seats.map((seat) => Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: Text(
                          seat.toString(),
                          style: theme.textTheme.titleLarge!
                              .copyWith(fontSize: 15.sp),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, top: 15.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lang.total,
                    style:
                        theme.textTheme.titleLarge!.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(total,
                      style:
                          theme.textTheme.titleLarge!.copyWith(fontSize: 15.sp))
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 30.h,
      ),
      Text(
        title,
        style: theme.textTheme.labelLarge!.copyWith(fontSize: 20.sp),
      ),
      SizedBox(
        height: 50.h,
      ),
    ]);
  }
}
