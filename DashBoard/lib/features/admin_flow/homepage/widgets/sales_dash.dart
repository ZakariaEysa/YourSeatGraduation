import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesDash extends StatelessWidget {
  final String colorHex;
  final String colorContainer;
  final String value;
  final String title;
  final String update;

  final String imagePath;

  const SalesDash({
    super.key,
    required this.colorContainer,
    required this.colorHex,
    required this.value,
    required this.title,
    required this.update,
    required this.imagePath,
  });

  Color getColorFromHex(String hexColor) {
    String formattedHex = hexColor.replaceAll("#", "");
    if (formattedHex.length == 6) {
      formattedHex = "FF$formattedHex";
    }
    return Color(int.parse(formattedHex, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorFromHex(colorHex),
      width: 55.w,
      // height: 175.h,
      child: Padding(
        padding: EdgeInsets.all(4.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 35.w, bottom: 12.h),
              child: Container(
                decoration: BoxDecoration(
                  color: getColorFromHex(colorContainer),
                  shape: BoxShape.circle,
                ),
                width: 40.w,
                height: 40.h,
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            //   SizedBox(height: 12.h),
            Text(
              value,
              style: TextStyle(
                color: const Color(0xFF151D48),
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF425166),
                fontSize: 5.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              update,
              style: TextStyle(
                color: const Color(0xFF4079ED),
                fontSize: 4.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
