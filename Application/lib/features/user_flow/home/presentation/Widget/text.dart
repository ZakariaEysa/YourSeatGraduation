import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextS extends StatelessWidget {
  final String text;
  const TextS({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 24.sp,
        fontFamily: 'SF Pro',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
