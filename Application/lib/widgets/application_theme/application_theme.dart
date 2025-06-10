import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/hive_keys.dart';
import '../../data/hive_storage.dart';

class ApplicationTheme extends ChangeNotifier {
  static bool _isDark = HiveStorage.get(HiveKeys.isDark);

  bool get isDark => _isDark;

  void toggleTheme({required bool isDark}) {
    if (_isDark == isDark) {
      return;

    }
    _isDark = isDark;
    HiveStorage.set(HiveKeys.isDark, _isDark);
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDark ? darkTheme : lightTheme;
  }

  static ThemeData lightTheme = ThemeData(
      primaryColor: const Color(0xFFFCFCFC),
      colorScheme: ColorScheme.fromSeed(
        onPrimary: Color(0xFF191645),
        primary: const Color(0xFFFCFCFC),
        secondary: const Color(0xFFFAF4F0),
        onSecondary: const Color(0xFF2E126E).withOpacity(0.9),
        seedColor: const Color(0xFFFCFCFC),
        onBackground: Color(0xFFB4A9A9),
        secondaryFixed: const Color(0xFFF4F3F1),
        primaryContainer: Color(0xFF2E1371),
        onPrimaryContainer: Color(0xFFB4A9A9),
        secondaryContainer: Color(0XFF3A1751),
        onSecondaryContainer: Color(0xFF191645),
        surface: const Color(0xFF0A3253), // available
        onSurface: const Color(0xFF6D646D), // reserved
        surfaceVariant: const Color(0xFF680B5F), // selected
      ),
      appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Color(0xFF191645),
          ),
          //  elevation: 0.0,
          // backgroundColor: Colors.transparent,
          backgroundColor: Color(0xFFFCFCFC),
          titleTextStyle: GoogleFonts.elMessiri(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          centerTitle: true),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFB7935F),
        selectedIconTheme: IconThemeData(color: Colors.black, size: 52),
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        unselectedItemColor: Colors.white,
      ),
      textTheme: TextTheme(
          labelLarge: GoogleFonts.aDLaMDisplay(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF191645)),
          titleLarge: GoogleFonts.poppins(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          titleMedium: GoogleFonts.pottaOne(
              fontSize: 19.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF191645)),
          bodyLarge: GoogleFonts.inter(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191645)),
          bodyMedium: GoogleFonts.poppins(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191645)),
          bodySmall: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              color: Color(0xFF191645))));

  static ThemeData darkTheme = ThemeData(
      primaryColor: const Color(0xFF2E1371),
      colorScheme: ColorScheme.fromSeed(
        onPrimary: Colors.white,
        onSecondary: const Color(0xFFD9D9D9).withOpacity(0.6),
        primary: const Color(0xFF2E1371),
        secondary: const Color(0xFF130B2B),
        secondaryFixed: const Color(0xFF191645),
        onBackground: Color(0xFF191645),
        seedColor: const Color(0xFF2E1371),
        primaryContainer: Color(0xFF2D1468),
        onPrimaryContainer: Color(0xFFD9D9D9),
        secondaryContainer: Color(0XFF37313B),
        onSecondaryContainer: Color(0xFF9C24D9),
        surface: const Color(0xFFF3F3F3), // available
        onSurface: const Color(0xFF5B085D), // reserved
        surfaceVariant: const Color(0xFF09FBD3), // selected
      ),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          //  elevation: 0.0,
          // backgroundColor: Colors.transparent,
          backgroundColor: Color(0xFF2E1371),
          titleTextStyle: GoogleFonts.aDLaMDisplay(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          centerTitle: true),

      // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Color(0xFFB7935F),
      //   selectedIconTheme: IconThemeData(color: Colors.black, size: 52),
      //   selectedItemColor: Colors.black,
      //   unselectedIconTheme: IconThemeData(color: Colors.white, size: 30),
      //   unselectedItemColor: Colors.white,
      // ),

      textTheme: TextTheme(
          labelLarge: GoogleFonts.aDLaMDisplay(
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          titleLarge: GoogleFonts.acme(
              fontSize: 25.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          titleMedium: GoogleFonts.pottaOne(
              fontSize: 19.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          bodyLarge: GoogleFonts.inter(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          bodyMedium: GoogleFonts.poppins(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          bodySmall: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white)),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Color(0xFF2C126A)));
}
