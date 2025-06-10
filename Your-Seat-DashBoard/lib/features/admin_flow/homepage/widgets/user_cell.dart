import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCell extends StatelessWidget {
  final String userNo;

  const UserCell({required this.userNo, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          userNo,
          style: TextStyle(color: const Color(0xFF656575), fontSize: 5.sp),
        ),
      ),
    );
  }
}
