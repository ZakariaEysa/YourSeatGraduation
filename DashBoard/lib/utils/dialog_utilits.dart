import 'package:flutter/material.dart';

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
                const CircularProgressIndicator(),
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
