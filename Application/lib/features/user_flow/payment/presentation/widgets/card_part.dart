import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';

class CardPart extends StatelessWidget {
  const CardPart({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              lang.cardNumber,
              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                width: 318.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2).withOpacity(.29),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFFF89F3).withOpacity(.30),
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: TextFormField(
                    obscureText: true,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 18.sp, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "**** **** **** ****",
                      hintStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFA59B9B),
                          letterSpacing: 3,
                          fontSize: 18.sp),
                    ),
                  ),
                )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              lang.expiryDate,
              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                width: 318.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2).withOpacity(.29),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFFF89F3).withOpacity(.30),
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: TextFormField(
                    obscureText: true,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 18.sp, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "MM / YYYY",
                      hintStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFA59B9B),
                          letterSpacing: 3,
                          fontSize: 18.sp),
                    ),
                  ),
                )),
            SizedBox(
              height: 20.h,
            ),
            Text(
              lang.cvv,
              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
                width: 318.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2).withOpacity(.29),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color(0xFFFF89F3).withOpacity(.30),
                    width: 1.w,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: TextFormField(
                    obscureText: true,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 18.sp, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "*****",
                      hintStyle: theme.textTheme.bodyMedium!.copyWith(
                          color: Color(0xFFA59B9B),
                          letterSpacing: 3,
                          fontSize: 18.sp),
                    ),
                  ),
                )),
          ]),
    );
  }
}
