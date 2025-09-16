import 'package:study_box/l10n/app_localizations.dart';

class LocalizationManager {
  static LocalizationManager? _instance;
  static LocalizationManager get instance {
    _instance ??= LocalizationManager._();
    return _instance!;
  }

  LocalizationManager._();

  AppLocalizations? _currentLocalizations;

  void updateLocalizations(AppLocalizations localizations) {
    _currentLocalizations = localizations;
  }

  AppLocalizations get tr {
    if (_currentLocalizations == null) {
      throw Exception(
        'LocalizationManager not initialized. Call updateLocalizations first.',
      );
    }
    return _currentLocalizations!;
  }

  static AppLocalizations get l => instance.tr;
}
