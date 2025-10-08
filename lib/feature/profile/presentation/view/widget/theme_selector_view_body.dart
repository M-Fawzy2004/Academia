import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/widget/icon_back.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_option_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_selector_header.dart';

class ThemeSelectorViewBody extends StatefulWidget {
  const ThemeSelectorViewBody({super.key});

  @override
  State<ThemeSelectorViewBody> createState() => ThemeSelectorViewBodyState();
}

class ThemeSelectorViewBodyState extends State<ThemeSelectorViewBody> {
  AppThemeMode selectedTheme = ThemeManager.instance.currentTheme;

  void onThemeSelected(AppThemeMode theme) {
    setState(() {
      selectedTheme = theme;
    });
    ThemeManager.instance.setTheme(theme);

    if (theme == AppThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;
      AppColors.setThemeMode(
        brightness == Brightness.dark ? ThemeMode2.dark : ThemeMode2.light,
      );
    } else if (theme == AppThemeMode.light) {
      AppColors.setThemeMode(ThemeMode2.light);
    } else if (theme == AppThemeMode.dark) {
      AppColors.setThemeMode(ThemeMode2.dark);
    } else if (theme == AppThemeMode.dark2) {
      AppColors.setThemeMode(ThemeMode2.dark2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightBox(20),
        Row(
          children: [
            const IconBack(),
            widthBox(15),
            const ThemeSelectorHeader(),
          ],
        ),
        heightBox(40),
        ThemeOptionCard(
          title: 'System Default',
          subtitle: 'Follow device settings',
          icon: Icons.brightness_auto_rounded,
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600],
          ),
          isSelected: selectedTheme == AppThemeMode.system,
          onTap: () => onThemeSelected(AppThemeMode.system),
        ),
        SizedBox(height: 16.h),
        ThemeOptionCard(
          title: 'Light Mode',
          subtitle: 'Bright and clean interface',
          icon: Icons.light_mode_rounded,
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade500],
          ),
          isSelected: selectedTheme == AppThemeMode.light,
          onTap: () => onThemeSelected(AppThemeMode.light),
        ),
        SizedBox(height: 16.h),
        ThemeOptionCard(
          title: 'Dark Mode',
          subtitle: 'Easy on the eyes',
          icon: Icons.dark_mode_rounded,
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.indigo.shade700],
          ),
          isSelected: selectedTheme == AppThemeMode.dark,
          onTap: () => onThemeSelected(AppThemeMode.dark),
        ),
        SizedBox(height: 16.h),
        ThemeOptionCard(
          title: 'Dark Mode 2',
          subtitle: 'Deep dark theme',
          icon: Icons.nightlight_round,
          gradient: LinearGradient(
            colors: [Colors.purple.shade700, Colors.deepPurple.shade900],
          ),
          isSelected: selectedTheme == AppThemeMode.dark2,
          onTap: () => onThemeSelected(AppThemeMode.dark2),
        ),
      ],
    );
  }
}
