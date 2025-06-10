import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../widgets/loading_indicator.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message,
      {bool isCancelable = true}) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2E1371),
            content: Row(
              children: [
                const LoadingIndicator(),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ))
              ],
            ),
          );
        },
        barrierDismissible: isCancelable);
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message,
      {String? posActionTitle,
      VoidCallback? posAction,
      String? negActionTitle,
      VoidCallback? negAction,
      bool isCancelable = true}) {
    showDialog(
        context: context,
        builder: (buildContext) {
          List<Widget> actions = [];

          if (posActionTitle != null) {
            actions.add(TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                  //Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                child: Text(
                  posActionTitle,
                  style: const TextStyle(color: Colors.white),
                )));
          }

          if (negActionTitle != null) {
            actions.add(TextButton(
                onPressed: () {
                  //Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(
                  negActionTitle,
                  style: const TextStyle(color: Colors.white),
                )));
          }

          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
            backgroundColor: const Color(0xFF2E1371),
            actions: actions,
            content: Row(
              children: [
                Expanded(
                    child: Text(
                  message,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ))
              ],
            ),
          );
        },
        barrierDismissible: isCancelable);
  }
}

void showCenteredSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w, // استخدام ScreenUtil للـ horizontal padding
            vertical: 12.h, // استخدام ScreenUtil للـ vertical padding
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(
                8.r), // استخدام ScreenUtil للـ borderRadius
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp, // استخدام ScreenUtil للـ fontSize
            ),
          ),
        ),
      ),
    ),
  );

  // إظهار الـ SnackBar
  overlay.insert(overlayEntry);

  // إخفاء الـ SnackBar بعد 3 ثواني
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
