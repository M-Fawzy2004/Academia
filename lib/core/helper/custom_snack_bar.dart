import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';

enum SnackBarType {
  success,
  error,
  info,
  warning,
}

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Color backgroundColor;
    Color borderColor;
    IconData icon;
    Color iconColor;
    Color textColor;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = AppColors.primaryColor;
        borderColor = AppColors.primaryColor.withOpacity(0.5);
        icon = Icons.check_circle_outline;
        iconColor = Colors.white;
        textColor = Colors.white;
        break;
      case SnackBarType.error:
        backgroundColor = const Color(0xFFE53E3E);
        borderColor = const Color(0xFFEF5350);
        icon = Icons.error_outline;
        iconColor = Colors.white;
        textColor = Colors.white;
        break;
      case SnackBarType.info:
        backgroundColor = AppColors.secondaryColor;
        borderColor = AppColors.secondaryColor.withOpacity(0.5);
        icon = Icons.info_outline;
        iconColor = Colors.white;
        textColor = Colors.white;
        break;
      case SnackBarType.warning:
        backgroundColor = const Color(0xFFFF9800);
        borderColor = const Color(0xFFFFB74D);
        icon = Icons.warning_amber_outlined;
        iconColor = Colors.white;
        textColor = Colors.white;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1.3.h,
              ),
            ),
          ),
          if (actionLabel != null && onActionPressed != null) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: onActionPressed,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                actionLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: borderColor,
          width: 1.w,
        ),
      ),
      elevation: 8,
      animation: CurvedAnimation(
        parent: AnimationController(
          duration: const Duration(milliseconds: 600),
          vsync: Navigator.of(context),
        ),
        curve: Curves.elasticOut,
      ),
      dismissDirection: DismissDirection.down,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final String display = formatForBuild(message);
    show(
      context: context,
      message: display,
      type: SnackBarType.error,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final String display = formatForBuild(message);
    show(
      context: context,
      message: display,
      type: SnackBarType.info,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final String display = formatForBuild(message);
    show(
      context: context,
      message: display,
      type: SnackBarType.warning,
      duration: duration,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static String formatForBuild(String message) {
    const bool isRelease = bool.fromEnvironment('dart.vm.product');
    if (isRelease) {
      // Hide internal details from end users
      if (message.toLowerCase().contains('exception') ||
          message.toLowerCase().contains('postgrest') ||
          message.toLowerCase().contains('storageexception')) {
        return 'An error occurred';
      }
      if (message.toLowerCase().contains('network')) {
        return 'Network error';
      }
      return 'Something went wrong';
    }
    // In debug/dev, show the raw error for developer visibility
    return message;
  }
}
