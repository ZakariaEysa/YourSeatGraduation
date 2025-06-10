import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      "assets/images/loading1.gif",
      width: 50.w,
      height: 50.h,
    ));
  }
}
