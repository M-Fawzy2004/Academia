import 'package:flutter/material.dart';

class LanguageHelper {
  /// check if current language is Arabic
  static bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  /// Get current language code
  static String getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  /// Check if current text direction is RTL
  static bool isRTL(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  /// Get current text direction
  static TextDirection getTextDirection(BuildContext context) {
    return isArabic(context) ? TextDirection.rtl : TextDirection.ltr;
  }

  /// Get current locale
  static Locale getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  /// Check if current locale is Arabic
  static bool isLanguage(BuildContext context, String languageCode) {
    return Localizations.localeOf(context).languageCode == languageCode;
  }
}
