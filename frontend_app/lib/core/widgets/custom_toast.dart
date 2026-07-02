import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, warning, info }

class CustomToast {
  static void show({
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange;
        break;
      case ToastType.info:
        backgroundColor = Colors.blue;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showSuccess(String message) {
    show(message: message, type: ToastType.success);
  }

  static void showError(String message) {
    show(message: message, type: ToastType.error);
  }

  static void showWarning(String message) {
    show(message: message, type: ToastType.warning);
  }

  static void showInfo(String message) {
    show(message: message, type: ToastType.info);
  }

  static void cancel() {
    Fluttertoast.cancel();
  }
}
