import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/theme/app_color.dart';

class ThemeSelectorBottomSheet extends StatefulWidget {
  const ThemeSelectorBottomSheet({super.key});

  @override
  State<ThemeSelectorBottomSheet> createState() =>
      _ThemeSelectorBottomSheetState();
}

class _ThemeSelectorBottomSheetState extends State<ThemeSelectorBottomSheet> {
  AppThemeMode selectedTheme = ThemeManager.instance.currentTheme;

  void _selectTheme(AppThemeMode theme) {
    setState(() {
      selectedTheme = theme;
    });
    ThemeManager.instance.setTheme(theme);
    AppColors.setThemeMode(theme == AppThemeMode.light
        ? ThemeMode2.light
        : theme == AppThemeMode.dark
            ? ThemeMode2.dark
            : ThemeMode2.dark2);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.getCardColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle Bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.getBorderColor(context),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Choose Theme',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.getTextColor(context),
            ),
          ),
          SizedBox(height: 20.h),
          // Theme Options
          _ThemeOptionTile(
            icon: Icons.light_mode_rounded,
            title: 'Light',
            gradient: LinearGradient(
              colors: [Colors.orange.shade300, Colors.orange.shade500],
            ),
            isSelected: selectedTheme == AppThemeMode.light,
            onTap: () => _selectTheme(AppThemeMode.light),
          ),
          SizedBox(height: 12.h),
          _ThemeOptionTile(
            icon: Icons.dark_mode_rounded,
            title: 'Dark',
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade700],
            ),
            isSelected: selectedTheme == AppThemeMode.dark,
            onTap: () => _selectTheme(AppThemeMode.dark),
          ),
          SizedBox(height: 12.h),
          _ThemeOptionTile(
            icon: Icons.nightlight_round,
            title: 'Dark 2',
            gradient: LinearGradient(
              colors: [Colors.purple.shade700, Colors.deepPurple.shade900],
            ),
            isSelected: selectedTheme == AppThemeMode.dark2,
            onTap: () => _selectTheme(AppThemeMode.dark2),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _ThemeOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Gradient gradient;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionTile({
    required this.icon,
    required this.title,
    required this.gradient,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.getBorderColor(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: AppColors.getTextColor(context),
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryColor,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
