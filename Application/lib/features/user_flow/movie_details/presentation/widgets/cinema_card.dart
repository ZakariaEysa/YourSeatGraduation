import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  bool isSelected;
  final void Function()? onTap;
  CinemaCard(
      {super.key,
      this.isSelected = false,
      required this.title,
      required this.imageUrl,
      this.onTap});

  @override
  _CinemaCardState createState() => _CinemaCardState();
}

class _CinemaCardState extends State<CinemaCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
          if (widget.onTap != null) {
            widget.onTap!();
          }
        });
      },
      child: Container(
        width: 350.w,
        height: 65.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF25123A),
          border: widget.isSelected
              ? Border.all(color: Colors.purple.shade700, width: 2)
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style:
                        theme.textTheme.titleLarge!.copyWith(fontSize: 20.sp),
                  ),
                  const Spacer(),
                  Image.asset(
                    widget.imageUrl,
                    width: 35.w,
                    height: 20.h,
                  )
                ],
              ),
              // SizedBox(
              //   height: 5.h,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     // Text(smalltitle,
              //     //     style: theme.textTheme.bodyMedium!.copyWith(
              //     //         fontSize: 12.sp, color: const Color(0xFFF2F2F2))),
              //     // SizedBox(
              //     //   width: 5.w,
              //     // ),
              //     // Image.asset(
              //     //   "assets/images/Line 20.png",
              //     //   height: 10.h,
              //     //   width: 10.w,
              //     //   color: Colors.white,
              //     // ),
              //     // SizedBox(
              //     //   width: 5.w,
              //     // ),
              //     // Text(largetitle,
              //     //     style: theme.textTheme.bodyMedium!.copyWith(
              //     //         fontSize: 11.sp, color: const Color(0xFFF2F2F2)))
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
