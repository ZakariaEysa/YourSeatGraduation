import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCell extends StatelessWidget {
  final bool isAvailable;

  const StatusCell({required this.isAvailable, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: isAvailable ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          isAvailable ? 'Available' : 'Unavailable',
          style: TextStyle(
            color: const Color(0xFF656575),
            fontSize: 5.sp,
          ),
        ),
      ],
    );
  }
}
