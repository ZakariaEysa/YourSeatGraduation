import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 45.h,
      right: 0,
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.red, size: 7.sp),
        onPressed: onPressed,
      ),
    );
  }
}
