import 'package:flutter/material.dart';
import 'package:study_box/core/theme/theme_manager.dart';
import 'package:study_box/core/helper/spacing.dart';
import 'package:study_box/core/localization/translate.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_option_card.dart';
import 'package:study_box/feature/profile/presentation/view/widget/theme_selector_header.dart';
import 'package:study_box/core/widget/icon_back.dart';

class ThemeSelectorViewBody extends StatefulWidget {
  const ThemeSelectorViewBody({super.key});

  @override
  State<ThemeSelectorViewBody> createState() => ThemeSelectorViewBodyState();
}

class ThemeSelectorViewBodyState extends State<ThemeSelectorViewBody> {
  AppThemeMode selectedTheme = ThemeManager.instance.currentTheme;

  @override
  void initState() {
    super.initState();
    ThemeManager.instance.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    ThemeManager.instance.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {
        selectedTheme = ThemeManager.instance.currentTheme;
      });
    }
  }

  Future<void> onThemeSelected(AppThemeMode theme) async {
    setState(() {
      selectedTheme = theme;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    await ThemeManager.instance.setTheme(theme);
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
        // System Default
        ThemeOptionCard(
          title: context.tr.system_default_title,
          subtitle: context.tr.system_default_desc,
          icon: Icons.brightness_auto_rounded,
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600],
          ),
          isSelected: selectedTheme == AppThemeMode.system,
          onTap: () => onThemeSelected(AppThemeMode.system),
        ),
        heightBox(16),
        // Light Mode
        ThemeOptionCard(
          title: context.tr.light_mode_title,
          subtitle: context.tr.light_mode_desc,
          icon: Icons.light_mode_rounded,
          gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade500],
          ),
          isSelected: selectedTheme == AppThemeMode.light,
          onTap: () => onThemeSelected(AppThemeMode.light),
        ),
        heightBox(16),
        // Dark Mode
        ThemeOptionCard(
          title: context.tr.dark_mode_title,
          subtitle: context.tr.dark_mode_desc,
          icon: Icons.dark_mode_rounded,
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.indigo.shade700],
          ),
          isSelected: selectedTheme == AppThemeMode.dark,
          onTap: () => onThemeSelected(AppThemeMode.dark),
        ),
        heightBox(16),
        // Dark Mode 2
        ThemeOptionCard(
          title: context.tr.dark_mode_two_title,
          subtitle: context.tr.dark_mode_two_desc,
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
