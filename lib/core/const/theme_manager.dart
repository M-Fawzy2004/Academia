import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_box/core/theme/app_color.dart';

enum AppThemeMode {
  light,
  dark,
  dark2,
}

class ThemeManager extends ChangeNotifier {
  static final ThemeManager instance = ThemeManager._internal();
  factory ThemeManager() => instance;
  ThemeManager._internal();

  AppThemeMode currentTheme = AppThemeMode.light;

  void setTheme(AppThemeMode theme) {
    currentTheme = theme;
    notifyListeners();
  }

  ThemeData getLightTheme() {
    return ThemeData(
      fontFamily: 'fontApp',
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.grey,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.grey,
        foregroundColor: AppColors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData(
      fontFamily: 'fontApp',
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimaryColor,
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackgroundColor,
        foregroundColor: AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  ThemeData getDark2Theme() {
    return ThemeData(
      fontFamily: 'fontApp',
      brightness: Brightness.dark,
      primaryColor: AppColors.dark2PrimaryColor,
      scaffoldBackgroundColor: AppColors.dark2BackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark2BackgroundColor,
        foregroundColor: AppColors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  ThemeData getCurrentTheme() {
    switch (currentTheme) {
      case AppThemeMode.light:
        return getLightTheme();
      case AppThemeMode.dark:
        return getDarkTheme();
      case AppThemeMode.dark2:
        return getDark2Theme();
    }
  }
}
