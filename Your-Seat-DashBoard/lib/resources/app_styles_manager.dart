import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';

class AppStylesManager {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const AppStylesManager({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });

  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
  //! app Style manager add more TextStyle if needed

  // example
  static TextStyle customTextStyleBl = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w700,
    color: ColorManager.primaryBL2,
    // fontFamily: HiveStorage.get(HiveKeys.isArabic) ? 'GE Dinar One' : 'Manrope',
    fontFamily: 'Manrope',
  );

  // example

  static List<BoxShadow> customBoxShadow() {
    return [
      const BoxShadow(
        color: Color(0x16949494),
        blurRadius: 14,
        offset: Offset(0, -14),
        spreadRadius: 0,
      ),
      const BoxShadow(
        color: Color(0x11949494),
        blurRadius: 16,
        offset: Offset(0, -28),
        spreadRadius: 0,
      ),
    ];
  }

  // example
  static ShapeDecoration buildContainerDecoration() {
    return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xFFE8EAED)),
        borderRadius: BorderRadius.circular(8.sp),
      ),
    );
  }

  static ShapeDecoration backGroundDecorations() {
    return ShapeDecoration(
      gradient: const LinearGradient(
        begin: Alignment(0.00, 1.00),
        end: Alignment(0, -1),
        colors: [Color(0xFF0E0A1C), Color(0xFF2F1472)],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.w,
          strokeAlign: BorderSide.strokeAlignOutside,
          color: const Color(0xFF8059E1),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.sp),
          topRight: Radius.circular(50.sp),
        ),
      ),
      shadows: [
        BoxShadow(
          color: const Color(0x3F000000),
          blurRadius: 8.sp,
          offset: const Offset(0, 4),
          spreadRadius: 15.sp,
        )
      ],
    );
  }
}
