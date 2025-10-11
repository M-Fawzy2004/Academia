import 'package:flutter/material.dart';
import 'package:study_box/core/const/theme_manager.dart'; 

enum ThemeMode2 {
  light,
  dark,
  dark2,
}

class AppColors {
  static const Color primaryColor = Color(0xFF667EEA);
  static const Color secondaryColor = Color(0xFF764BA2);
  static const Color primaryGradientStart = Color(0xFF667EEA);
  static const Color primaryGradientEnd = Color(0xFF764BA2);

  // Light Theme Colors
  static const Color lightBackgroundColor = Color(0xFFF8FAFC);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color lightCardColor = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A202C);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorderColor = Color(0xFFE2E8F0);
  static const Color lightGreyBackground = Color(0xFFF1F5F9);
  static const Color lightIndicatorInactive = Color(0xFFE2E8F0);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF667EEA);
  static const Color darkBackgroundColor = Color.fromARGB(255, 30, 30, 30);
  static const Color darkSurfaceColor = Color.fromARGB(255, 37, 37, 38);
  static const Color darkCardColor = Color.fromARGB(255, 27, 33, 43);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorderColor = Color(0xFF475569);
  static const Color darkGreyBackground = Color(0xFF374151);
  static const Color darkIndicatorInactive = Color(0xFF475569);

  // Dark Theme 2 Colors
  static const Color dark2PrimaryColor = Color(0xFF4A7FA7);
  static const Color dark2BackgroundColor = Color(0xFF0A1931);
  static const Color dark2SurfaceColor = Color(0xFF1A3D63);
  static const Color dark2CardColor = Color(0xFFB3CFE5);
  static const Color dark2TextPrimary = Color(0xFFF6FAFD);
  static const Color dark2TextSecondary = Color(0xFFB3CFE5);
  static const Color dark2BorderColor = Color(0xFF4A7FA7);
  static const Color dark2GreyBackground = Color(0xFF1A3D63);
  static const Color dark2IndicatorInactive = Color(0xFF4A7FA7);

  // Common Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Legacy Colors
  static const Color darkGrey = Color(0xFF000000);
  static const Color backgroundColor = Color(0xFF1C1C1E);
  static const Color whitewithOpacity = Color(0xFFF3F2F8);
  static const Color grey = Color(0xFFF5F5F5);
  static const Color lightGrey = Color(0xFFA1A5B1);
  static const Color lightBlueGrey = Color(0xFFF0F2FC);
  static const Color darkLightGrey = Color(0xFF8E8E93);

  // Gradient Methods
  static LinearGradient getPrimaryGradient() {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primaryGradientStart, primaryGradientEnd],
    );
  }

  static LinearGradient getDarkPrimaryGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        darkPrimaryColor.withOpacity(0.8),
        darkSurfaceColor.withOpacity(0.9),
      ],
    );
  }

  static LinearGradient getDark2PrimaryGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        dark2PrimaryColor.withOpacity(0.8),
        dark2SurfaceColor.withOpacity(0.9),
      ],
    );
  }

  static bool _isDark2(BuildContext context) {
    return ThemeManager.instance.isDark2Theme(context);
  }

  static bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Dynamic Color Methods
  static Color getBackgroundColor(BuildContext context) {
    if (_isDark2(context)) return dark2BackgroundColor;
    return _isDark(context) ? darkBackgroundColor : lightBackgroundColor;
  }

  static Color getSurfaceColor(BuildContext context) {
    if (_isDark2(context)) return dark2SurfaceColor;
    return _isDark(context) 
        ? const Color.fromRGBO(30, 41, 59, 1) 
        : lightSurfaceColor;
  }

  static Color getCardColor(BuildContext context) {
    if (_isDark2(context)) return dark2BackgroundColor;
    return _isDark(context) ? darkBackgroundColor : lightCardColor;
  }

  static Color getCardColorTwo(BuildContext context) {
    if (_isDark2(context)) return dark2SurfaceColor;
    return _isDark(context) ? darkSurfaceColor : lightCardColor;
  }

  static Color getFieldColor(BuildContext context) {
    if (_isDark2(context)) return dark2SurfaceColor;
    return _isDark(context) ? darkSurfaceColor : lightCardColor;
  }

  static Color getNavigationBar(BuildContext context) {
    if (_isDark2(context)) return dark2SurfaceColor;
    return _isDark(context) ? darkSurfaceColor : white;
  }

  static Color getTextPrimaryColor(BuildContext context) {
    if (_isDark2(context)) return dark2TextPrimary;
    return _isDark(context) ? darkTextPrimary : lightTextPrimary;
  }

  static Color getTextSecondaryColor(BuildContext context) {
    if (_isDark2(context)) return dark2TextSecondary;
    return _isDark(context) ? darkTextSecondary : lightTextSecondary;
  }

  static Color getBorderColor(BuildContext context) {
    if (_isDark2(context)) return dark2BorderColor;
    return _isDark(context) ? darkBorderColor : lightBorderColor;
  }

  static Color getGreyBackgroundColor(BuildContext context) {
    if (_isDark2(context)) return dark2GreyBackground;
    return _isDark(context) ? darkGreyBackground : lightGreyBackground;
  }

  static Color getIndicatorInactiveColor(BuildContext context) {
    if (_isDark2(context)) return dark2IndicatorInactive;
    return _isDark(context) ? darkIndicatorInactive : lightIndicatorInactive;
  }

  // Legacy Methods
  static Color getTextColor(BuildContext context) {
    return getTextPrimaryColor(context);
  }

  static Color getGreyColor(BuildContext context) {
    if (_isDark2(context)) return dark2GreyBackground;
    return _isDark(context) ? darkGreyBackground : grey;
  }

  static Color getLightGreyColor(BuildContext context) {
    return _isDark(context) ? darkLightGrey : lightGrey;
  }

  static Color getPrimaryColor(BuildContext context) {
    return primaryColor;
  }

  static Color getDarkGreyColor(BuildContext context) {
    return _isDark(context)
        ? const Color.fromARGB(255, 156, 154, 154)
        : darkGrey;
  }

  static Color getGreyShade600(BuildContext context) {
    return _isDark(context)
        ? const Color.fromARGB(255, 156, 154, 154)
        : const Color(0xFF757575);
  }

  static Color getSkipButtonBackground(BuildContext context) {
    return _isDark(context)
        ? white.withOpacity(0.15)
        : white.withOpacity(0.2);
  }

  static Color getSkipButtonForeground(BuildContext context) {
    return white;
  }

  static LinearGradient getOnboardingGradient(BuildContext context) {
    if (_isDark2(context)) return getDark2PrimaryGradient();
    return _isDark(context) ? getDarkPrimaryGradient() : getPrimaryGradient();
  }

  static Color getOnboardingShapeColor(BuildContext context) {
    return _isDark(context)
        ? white.withOpacity(0.08)
        : white.withOpacity(0.1);
  }
}