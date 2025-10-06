import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeSelectorButton extends StatelessWidget {
  final VoidCallback onTap;

  const ThemeSelectorButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = ThemeManager.instance.currentTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46.w,
        height: 46.h,
        decoration: BoxDecoration(
          color: AppColors.getCardColor(context),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          currentTheme == AppThemeMode.light
              ? Icons.light_mode_rounded
              : currentTheme == AppThemeMode.dark
                  ? Icons.dark_mode_rounded
                  : Icons.nightlight_round,
          size: 22.sp,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
