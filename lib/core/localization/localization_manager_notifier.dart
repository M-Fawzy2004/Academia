import 'package:flutter/material.dart';
import 'package:study_box/l10n/app_localizations.dart';

class LocalizationManagerNotifier extends ChangeNotifier {
  static LocalizationManagerNotifier? _instance;
  static LocalizationManagerNotifier get instance {
    _instance ??= LocalizationManagerNotifier._();
    return _instance!;
  }

  LocalizationManagerNotifier._();

  AppLocalizations? _currentLocalizations;

  void updateLocalizations(AppLocalizations localizations) {
    _currentLocalizations = localizations;
    notifyListeners();
  }

  AppLocalizations get tr {
    if (_currentLocalizations == null) {
      throw Exception('LocalizationManager not initialized.');
    }
    return _currentLocalizations!;
  }
}
