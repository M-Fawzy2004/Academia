import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

enum FlushbarType {
  success,
  error,
  info,
  warning,
}

class CustomFlushbar {
  static void show({
    required BuildContext context,
    required String message,
    required FlushbarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    IconData icon;
    Color iconColor;

    switch (type) {
      case FlushbarType.success:
        backgroundColor = const Color(0xFF4CAF50);
        icon = Icons.check_circle;
        iconColor = Colors.white;
        break;
      case FlushbarType.error:
        backgroundColor = const Color(0xFFE53E3E);
        icon = Icons.error;
        iconColor = Colors.white;
        break;
      case FlushbarType.info:
        backgroundColor = const Color(0xFF2196F3);
        icon = Icons.info;
        iconColor = Colors.white;
        break;
      case FlushbarType.warning:
        backgroundColor = const Color(0xFFFF9800);
        icon = Icons.warning;
        iconColor = Colors.white;
        break;
    }

    Flushbar(
      message: message,
      duration: duration,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      leftBarIndicatorColor: Colors.white.withOpacity(0.3),
      icon: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Icon(
          icon,
          size: 24,
          color: iconColor,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      boxShadows: [
        BoxShadow(
          color: backgroundColor.withOpacity(0.3),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    ).show(context);
  }

  // طرق مساعدة لكل نوع
  static void showSuccess(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      type: FlushbarType.success,
    );
  }

  static void showError(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      type: FlushbarType.error,
    );
  }

  static void showInfo(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      type: FlushbarType.info,
    );
  }

  static void showWarning(BuildContext context, String message) {
    show(
      context: context,
      message: message,
      type: FlushbarType.warning,
    );
  }
}
