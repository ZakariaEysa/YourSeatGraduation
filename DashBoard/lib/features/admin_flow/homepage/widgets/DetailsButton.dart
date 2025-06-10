import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF560B76),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Details',
            style: TextStyle(color: Colors.white, fontSize: 5.sp),
          ),
        ),
      ),
    );
  }
}
