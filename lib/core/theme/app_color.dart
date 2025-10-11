import 'package:flutter/material.dart';

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
  static const Color dark2PrimaryColor = Color(0xFF667EEA);
  static const Color dark2BackgroundColor = Color(0xFF0F172A);
  static const Color dark2SurfaceColor = Color(0xFF1E293B);
  static const Color dark2CardColor = Color(0xFF334155);
  static const Color dark2TextPrimary = Color(0xFFF8FAFC);
  static const Color dark2TextSecondary = Color(0xFF94A3B8);
  static const Color dark2BorderColor = Color(0xFF475569);
  static const Color dark2GreyBackground = Color(0xFF374151);
  static const Color dark2IndicatorInactive = Color(0xFF475569);

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

  static ThemeMode2 currentThemeMode = ThemeMode2.light;

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

  // Dynamic Color Methods
  static Color getBackgroundColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2BackgroundColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor
        : lightBackgroundColor;
  }

  static Color getSurfaceColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2SurfaceColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(30, 41, 59, 1)
        : lightSurfaceColor;
  }

  static Color getCardColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2BackgroundColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor
        : lightCardColor;
  }

  static Color getCardColorTwo(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2SurfaceColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : lightCardColor;
  }

  static Color getFieldColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2SurfaceColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : lightCardColor;
  }

  static Color getNavigationBar(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2SurfaceColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : white;
  }

  static Color getTextPrimaryColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2TextPrimary;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color getTextSecondaryColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2TextSecondary;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color getBorderColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2BorderColor;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderColor
        : lightBorderColor;
  }

  static Color getGreyBackgroundColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2GreyBackground;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkGreyBackground
        : lightGreyBackground;
  }

  static Color getIndicatorInactiveColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2IndicatorInactive;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkIndicatorInactive
        : lightIndicatorInactive;
  }

  // Legacy Methods
  static Color getTextColor(BuildContext context) {
    return getTextPrimaryColor(context);
  }

  static Color getGreyColor(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return dark2GreyBackground;
    }
    return Theme.of(context).brightness == Brightness.dark
        ? darkGreyBackground
        : grey;
  }

  static Color getLightGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkLightGrey
        : lightGrey;
  }

  static Color getPrimaryColor(BuildContext context) {
    return primaryColor;
  }

  static Color getDarkGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 156, 154, 154)
        : darkGrey;
  }

  static Color getGreyShade600(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 156, 154, 154)
        : const Color(0xFF757575);
  }

  // Skip Button Colors for Onboarding
  static Color getSkipButtonBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? white.withOpacity(0.15)
        : white.withOpacity(0.2);
  }

  static Color getSkipButtonForeground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? white : white;
  }

  // Onboarding Gradient
  static LinearGradient getOnboardingGradient(BuildContext context) {
    if (currentThemeMode == ThemeMode2.dark2) {
      return getDark2PrimaryGradient();
    }
    return Theme.of(context).brightness == Brightness.dark
        ? getDarkPrimaryGradient()
        : getPrimaryGradient();
  }

  // Onboarding Background Shapes
  static Color getOnboardingShapeColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? white.withOpacity(0.08)
        : white.withOpacity(0.1);
  }

  // Method لتغيير الوضع
  static void setThemeMode(ThemeMode2 mode) {
    currentThemeMode = mode;
  }
}
