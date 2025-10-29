import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_box/core/theme/app_color.dart';

enum AppThemeMode {
  light,
  dark,
  dark2,
  system,
}

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  static ThemeManager get instance => _instance;

  ThemeManager._internal();

  AppThemeMode _currentTheme = AppThemeMode.light;
  AppThemeMode get currentTheme => _currentTheme;

  AppThemeMode getEffectiveTheme(BuildContext context) {
    if (_currentTheme == AppThemeMode.system) {
      final brightness = MediaQuery.of(context).platformBrightness;
      return brightness == Brightness.dark
          ? AppThemeMode.dark
          : AppThemeMode.light;
    }
    return _currentTheme;
  }

  bool isDark2Theme(BuildContext context) {
    return getEffectiveTheme(context) == AppThemeMode.dark2;
  }

  bool isDarkTheme(BuildContext context) {
    final theme = getEffectiveTheme(context);
    return theme == AppThemeMode.dark || theme == AppThemeMode.dark2;
  }

  ThemeMode getThemeMode() {
    switch (_currentTheme) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.dark2:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  //  Light Theme
  ThemeData getCurrentTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'fontApp',

      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.lightBackgroundColor,
      cardColor: AppColors.lightCardColor,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurfaceColor,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
        titleLarge: TextStyle(color: AppColors.lightTextPrimary),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.lightTextPrimary,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightTextSecondary,
      ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        surface: AppColors.lightSurfaceColor,
        error: AppColors.error,
      ),
    );
  }

  ThemeData getCurrentDarkTheme() {
    if (_currentTheme == AppThemeMode.dark2) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: 'fontApp',
        primaryColor: AppColors.dark2PrimaryColor,
        scaffoldBackgroundColor: AppColors.dark2BackgroundColor,
        cardColor: AppColors.dark2CardColor,

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.dark2SurfaceColor,
          foregroundColor: AppColors.dark2TextPrimary,
          elevation: 0,
        ),

        // Text Theme
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.dark2TextPrimary),
          bodyMedium: TextStyle(color: AppColors.dark2TextSecondary),
          titleLarge: TextStyle(color: AppColors.dark2TextPrimary),
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: AppColors.dark2TextPrimary,
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.dark2SurfaceColor,
          selectedItemColor: AppColors.dark2PrimaryColor,
          unselectedItemColor: AppColors.dark2TextSecondary,
        ),

        colorScheme: const ColorScheme.dark(
          primary: AppColors.dark2PrimaryColor,
          secondary: AppColors.dark2PrimaryColor,
          surface: AppColors.dark2SurfaceColor,
          error: AppColors.error,
        ),
      );
    }

    // Dark Theme
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'fontApp',
      primaryColor: AppColors.darkPrimaryColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      cardColor: AppColors.darkCardColor,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurfaceColor,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
        titleLarge: TextStyle(color: AppColors.darkTextPrimary),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.darkTextPrimary,
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurfaceColor,
        selectedItemColor: AppColors.darkPrimaryColor,
        unselectedItemColor: AppColors.darkTextSecondary,
      ),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimaryColor,
        secondary: AppColors.secondaryColor,
        surface: AppColors.darkSurfaceColor,
        error: AppColors.error,
      ),
    );
  }

  Future<void> setTheme(AppThemeMode theme) async {
    _currentTheme = theme;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', theme.name);
  }

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme_mode');

    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _currentTheme = AppThemeMode.light;
          break;
        case 'dark':
          _currentTheme = AppThemeMode.dark;
          break;
        case 'dark2':
          _currentTheme = AppThemeMode.dark2;
          break;
        case 'system':
          _currentTheme = AppThemeMode.system;
          break;
        default:
          _currentTheme = AppThemeMode.system;
      }
    } else {
      _currentTheme = AppThemeMode.system;
    }

    notifyListeners();
  }
}
