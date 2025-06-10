import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatsType extends StatelessWidget {
  final Color color;
  final String text;
  const SeatsType({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 21.w,
          height: 21.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.sp),
          ),
        ),
        SizedBox(width: 4.sp),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
