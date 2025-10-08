import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeSelectorButton extends StatelessWidget {
  const ThemeSelectorButton({super.key});

  void _toggleTheme() {
    final currentTheme = ThemeManager.instance.currentTheme;

    // change theme
    if (currentTheme == AppThemeMode.light) {
      ThemeManager.instance.setTheme(AppThemeMode.dark);
    } else {
      ThemeManager.instance.setTheme(AppThemeMode.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeManager.instance,
      builder: (context, _) {
        final currentTheme = ThemeManager.instance.currentTheme;
        return GestureDetector(
          onTap: _toggleTheme,
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
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              size: 22.sp,
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
