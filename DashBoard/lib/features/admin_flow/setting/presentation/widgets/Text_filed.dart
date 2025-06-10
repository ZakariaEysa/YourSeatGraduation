import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFiled extends StatelessWidget {
  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? errorText;

  const TextFiled({
    super.key,
    this.hintText,
    this.label,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 13.w, right: 12.w),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 3.sp,
                color: const Color(0XFF000000),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 60.w),
          child: SizedBox(
            width: 180.w,
            height: 65.67.h,
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              style: TextStyle(fontSize: 5.sp, color: Colors.black),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: Color(0XFFEB68E3),
                    width: 0.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.r),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0XFFEB68E3),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xFF837D7D),
                  fontSize: 3.sp,
                ),
                errorText: errorText,
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 2.5.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
