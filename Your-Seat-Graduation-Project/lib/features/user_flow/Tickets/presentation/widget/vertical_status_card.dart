import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalStatusCard extends StatelessWidget {
  final String status;
  final String imagePath;
  final double imageWidth;
  final double imageHeight;

  const VerticalStatusCard({
    super.key,
    required this.status,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Container(
        width: 36.w,
        height: 140.h,
        decoration: BoxDecoration(
          color: const Color(0xFF25105A),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            ClipOval(
              child: Image.asset(
                imagePath,
                width: imageWidth.w,
                height: imageHeight.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
