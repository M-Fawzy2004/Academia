import 'package:flutter/widgets.dart';
import 'package:study_box/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
