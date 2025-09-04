import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The title of the onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get onboarding;

  /// The title of the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'StudyBox – All your study materials in one place'**
  String get onboarding_title1;

  /// The description of the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Gather your subjects, files, and notes in one simple app that helps you organize your studies without confusion.'**
  String get onboarding_desc1;

  /// The title of the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Organize your subjects easily'**
  String get onboarding_title2;

  /// The description of the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Create a section for each subject and keep all your files, notes, and recordings together for quick access.'**
  String get onboarding_desc2;

  /// The title of the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Your notes and files in a safe place'**
  String get onboarding_title3;

  /// The description of the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Write your notes, upload your files, and save your recordings so you can review them anytime, anywhere.'**
  String get onboarding_desc3;

  /// The skip button of the onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// The next button of the onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// The done button of the onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get onboarding_start_now;

  /// The title of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// The title of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Ready to start your study journey with StudyBox'**
  String get welcome_title;

  /// The description of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Organize your materials, save your files and notes, and keep your studies organized the way you like.'**
  String get welcome_desc;

  /// The login button of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get welcome_button_login;

  /// The register button of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get welcome_button_register;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
