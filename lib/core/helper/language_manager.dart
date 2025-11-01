import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  static LanguageManager? _instance;

  String _currentLanguage = 'en';

  static LanguageManager get instance {
    _instance ??= LanguageManager._();
    return _instance!;
  }

  LanguageManager._();

  String get currentLanguage => _currentLanguage;

  // languages
  static const Map<String, String> availableLanguages = {
    'en': 'English',
    'ar': 'العربية',
    'fr': 'Français',
    'es': 'Español',
  };

  // get current language
  String get currentLanguageName =>
      availableLanguages[_currentLanguage] ?? 'English';

  // load saved language
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString(_languageKey) ?? 'en';
    notifyListeners();
  }

  // change language
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage == languageCode) return;

    _currentLanguage = languageCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }

  // get current locale
  Locale get currentLocale {
    return Locale(_currentLanguage);
  }
}
