import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

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
    Locale('en'),
    Locale('es'),
    Locale('fr')
  ];

  /// Main title of the Onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get onboarding;

  /// Title of the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'StudyBox – All your studies in one place'**
  String get onboarding_title1;

  /// Description of the first onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Gather your materials, files, and notes in one simple app that helps you organize your studies without confusion'**
  String get onboarding_desc1;

  /// Title of the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Organize your subjects easily'**
  String get onboarding_title2;

  /// Description of the second onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Create a section for each subject, keeping all files, notes, and recordings together for quick access'**
  String get onboarding_desc2;

  /// Title of the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Your notes and files are safe'**
  String get onboarding_title3;

  /// Description of the third onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Write your notes, upload your files, and save your audio recordings to review anytime, anywhere'**
  String get onboarding_desc3;

  /// Skip button in onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// Next button in onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// Start (Done) button in onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get onboarding_start_now;

  /// Special translation of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Title of the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Ready to start your study journey with StudyBox?'**
  String get welcome_title;

  /// Description in the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Organize your subjects, save your files and notes, and keep your studies structured the way you like'**
  String get welcome_desc;

  /// Login button in the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get welcome_button_login;

  /// Register button in the welcome screen
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get welcome_button_register;

  /// Login screen translation
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Email field in login screen
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_email;

  /// Password field in login screen
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_pass;

  /// Forgot password button in login screen
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get login_forgot;

  /// Login button in login screen
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button;

  /// Navigate to register screen
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_register;

  /// Text before register button in login screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_not_have_an_account;

  /// Login with Google button
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_with_google;

  /// Login with Apple button
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get login_with_apple;

  /// Separator text in login screen
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get login_or;

  /// Register screen translation
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Username field in register screen
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get register_username;

  /// Confirm password field in register screen
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get register_confirm_pass;

  /// Text before login button in register screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get register_have_an_account;

  /// Forgot password screen translation
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forget;

  /// Reset password button
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forget_reset;

  /// Send verification code button
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get enter_verfivcation_code;

  /// Identity confirmation button
  ///
  /// In en, this message translates to:
  /// **'Identity Confirmation'**
  String get identity_confirmation;

  /// Save password button
  ///
  /// In en, this message translates to:
  /// **'Save Password'**
  String get save_pass;

  /// Helper text for email field
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enter_email;

  /// Resend code button
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// Back to previous step button
  ///
  /// In en, this message translates to:
  /// **'Back to previous step'**
  String get back_step;

  /// Helper text for code sent
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get send_code_with_email;

  /// Helper text for verification code field
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code'**
  String get enter_code;

  /// Verification code label
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verf_code;

  /// Confirm code button
  ///
  /// In en, this message translates to:
  /// **'Confirm Code'**
  String get confirm_code;

  /// Helper text for new password field
  ///
  /// In en, this message translates to:
  /// **'Please enter a new password'**
  String get enter_new_pass;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_pass;

  /// Password minimum length validation
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get pass_at_least;

  /// Confirm email button
  ///
  /// In en, this message translates to:
  /// **'Confirm Email'**
  String get confirm_email;

  /// Verify button
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verf;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_button;

  /// Resend button text
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend_button;

  /// Waiting text during countdown
  ///
  /// In en, this message translates to:
  /// **'Waiting...'**
  String get waiting_text;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Successfully logged in'**
  String get successfully_logged_in;

  /// Account verification success message
  ///
  /// In en, this message translates to:
  /// **'Account verified and created successfully'**
  String get account_verified_created;

  /// Error when email not found
  ///
  /// In en, this message translates to:
  /// **'Email not found'**
  String get email_not_found;

  /// Validation for verification code required
  ///
  /// In en, this message translates to:
  /// **'Verification code is required'**
  String get verification_code_required;

  /// Validation for verification code length
  ///
  /// In en, this message translates to:
  /// **'Verification code must be 6 digits'**
  String get verification_code_6_digits;

  /// Important notes section title
  ///
  /// In en, this message translates to:
  /// **'Important Notes:'**
  String get important_notes;

  /// Note about spam folder
  ///
  /// In en, this message translates to:
  /// **'Check your spam folder if you didn\'t receive the email'**
  String get check_spam_folder;

  /// Note about code expiration
  ///
  /// In en, this message translates to:
  /// **'Verification code expires in 10 minutes'**
  String get code_expires_10_minutes;

  /// Note about account creation timing
  ///
  /// In en, this message translates to:
  /// **'Your account will be created only after verification'**
  String get account_created_after_verification;

  /// Validation for email required
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get email_required;

  /// Validation for valid email format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get valid_email_required;

  /// Validation for password required
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_required;

  /// Validation for minimum password length
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_6_characters;

  /// Validation for confirm password
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirm_password_required;

  /// Validation when passwords don't match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_not_match;

  /// Validation for username required
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get please_enter_username;

  /// Validation for minimum username length
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get username_3_characters;

  /// Validation for maximum username length
  ///
  /// In en, this message translates to:
  /// **'Username must be less than 20 characters'**
  String get username_20_characters;

  /// Validation for username format
  ///
  /// In en, this message translates to:
  /// **'Username can only contain letters, numbers, and underscores'**
  String get username_letters_numbers_underscores;

  /// Validation for email required
  ///
  /// In en, this message translates to:
  /// **'Please enter an email'**
  String get please_enter_email;

  /// Validation for email format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get valid_email_address;

  /// Validation for password required
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get please_enter_password;

  /// Validation for minimum password length
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_6_chars_minimum;

  /// Validation for maximum password length
  ///
  /// In en, this message translates to:
  /// **'Password must be less than 50 characters'**
  String get password_50_chars_maximum;

  /// Validation for password complexity
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one letter and one number'**
  String get password_letter_number;

  /// Validation for confirm password required
  ///
  /// In en, this message translates to:
  /// **'Please enter confirm password'**
  String get please_enter_confirm_password;

  /// Generic validation for required field
  ///
  /// In en, this message translates to:
  /// **'Please fill out this field'**
  String get please_enter_field;

  /// Validation for phone number required
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get please_enter_phone;

  /// Validation for Egyptian phone number format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid Egyptian phone number'**
  String get valid_egyptian_phone;

  /// Validation for name required
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get please_enter_name;

  /// Validation for minimum name length
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get name_2_characters;

  /// Validation for maximum name length
  ///
  /// In en, this message translates to:
  /// **'Name must be less than 50 characters'**
  String get name_50_characters;

  /// Validation for name format
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters and spaces'**
  String get name_letters_spaces;

  /// Validation for age required
  ///
  /// In en, this message translates to:
  /// **'Please enter age'**
  String get please_enter_age;

  /// Validation for valid age format
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age'**
  String get valid_age;

  /// Validation for minimum age
  ///
  /// In en, this message translates to:
  /// **'Age must be at least 13'**
  String get age_minimum_13;

  /// Warning when no email found during registration
  ///
  /// In en, this message translates to:
  /// **'Warning: Email not found in registration response'**
  String get warning_email_not_found;

  /// Label to show the email address
  ///
  /// In en, this message translates to:
  /// **'Sent to:'**
  String get sent_to;

  /// Error message when account creation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to create account'**
  String get failed_to_create_account;

  /// Error message when login credentials are invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalid_credentials;

  /// Message when Google sign-in is cancelled
  ///
  /// In en, this message translates to:
  /// **'Google sign-in was cancelled'**
  String get google_signin_cancelled;

  /// Error message when Google authentication fails
  ///
  /// In en, this message translates to:
  /// **'Failed to authenticate with Google'**
  String get failed_authenticate_google;

  /// General error message for Google sign-in failure
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed'**
  String get google_signin_failed;

  /// Error message when Apple authentication fails
  ///
  /// In en, this message translates to:
  /// **'Failed to authenticate with Apple'**
  String get failed_authenticate_apple;

  /// General error message for Apple sign-in failure
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in failed'**
  String get apple_signin_failed;

  /// Success message for email verification
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully'**
  String get email_verified_successfully;

  /// Error message when email verification fails
  ///
  /// In en, this message translates to:
  /// **'Email verification failed'**
  String get email_verification_failed;

  /// Success message for password reset code verification
  ///
  /// In en, this message translates to:
  /// **'Password reset code verified successfully'**
  String get password_reset_verified_successfully;

  /// Error message when password reset code verification fails
  ///
  /// In en, this message translates to:
  /// **'Password reset code verification failed'**
  String get password_reset_verification_failed;

  /// Success message for sending verification email
  ///
  /// In en, this message translates to:
  /// **'Verification email sent successfully'**
  String get verification_email_sent_successfully;

  /// Error message when sending verification email fails
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification email'**
  String get failed_send_verification_email;

  /// Success message for sending password reset email
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully'**
  String get password_reset_email_sent_successfully;

  /// Error message when sending password reset email fails
  ///
  /// In en, this message translates to:
  /// **'Failed to send password reset email'**
  String get failed_send_password_reset_email;

  /// Success message for password update
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get password_updated_successfully;

  /// Error message when password update fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update password'**
  String get failed_update_password;

  /// Error message when no authenticated user exists
  ///
  /// In en, this message translates to:
  /// **'No authenticated user found'**
  String get no_authenticated_user_found;

  /// Error message when fetching current user fails
  ///
  /// In en, this message translates to:
  /// **'Failed to get current user data'**
  String get failed_get_current_user;

  /// Error message when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get name_cannot_be_empty;

  /// Error message when profile update fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get failed_update_profile;

  /// Error message when sign out fails
  ///
  /// In en, this message translates to:
  /// **'Failed to sign out'**
  String get failed_sign_out;

  /// Error message for invalid login credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalid_email_or_password;

  /// Message requesting email verification before sign in
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before signing in'**
  String get please_verify_email_before_signin;

  /// Message when account already exists
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get account_already_exists;

  /// Minimum password length message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_must_be_6_characters;

  /// Message requesting a valid email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get please_enter_valid_email;

  /// Message when new sign-ups are disabled
  ///
  /// In en, this message translates to:
  /// **'New sign-ups are currently disabled'**
  String get signup_disabled;

  /// Message when request rate limit is exceeded
  ///
  /// In en, this message translates to:
  /// **'Request limit exceeded. Please try again later'**
  String get email_rate_limit_exceeded;

  /// Message when verification code is expired
  ///
  /// In en, this message translates to:
  /// **'Verification code has expired. Please request a new one'**
  String get verification_code_expired;

  /// Message when verification code is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code. Please check and try again'**
  String get invalid_verification_code;

  /// Message for expired or invalid verification code
  ///
  /// In en, this message translates to:
  /// **'Verification code is expired or invalid. Please request a new one'**
  String get verification_code_expired_or_invalid;

  /// General unexpected error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpected_error_occurred;

  /// Message requesting name input
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get name_is_required;

  /// Message requesting password input
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get password_is_required;

  /// Password length requirement message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get password_must_be_6_chars;

  /// Error message for invalid login credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalid_login_credentials;

  /// Message when email is not verified
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before signing in'**
  String get email_not_confirmed;

  /// Message when user already registered
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get user_already_registered;

  /// Password length requirement message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get password_min_length;

  /// Message when email is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalid_email;

  /// Navigation bar text for home View
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_text_navigationbar;

  /// Navigation bar text for Subjects View
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subject_text_navigationbar;

  /// Navigation bar text for Reminders View
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders_text_navigationbar;

  /// Navigation bar text for profile View
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_text_navigationbar;

  /// Text for welcome back
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// Text for ready learning
  ///
  /// In en, this message translates to:
  /// **'Ready to Continue Learning'**
  String get ready_learning;

  /// Text for study streak
  ///
  /// In en, this message translates to:
  /// **'Study Streak'**
  String get study_streak;

  /// Text for daily inspiration
  ///
  /// In en, this message translates to:
  /// **'Daily Inspiration'**
  String get daily_inspiration;

  /// Text for total subjects
  ///
  /// In en, this message translates to:
  /// **'Total Subjects'**
  String get total_subject;

  /// Text for tasks
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// Text for completed tasks
  ///
  /// In en, this message translates to:
  /// **'Completed Tasks'**
  String get completed_tasks;

  /// Text for upcoming tasks
  ///
  /// In en, this message translates to:
  /// **'Upcoming Tasks'**
  String get upcoming_tasks;

  /// Text for view all
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// Text for subject
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subject;

  /// Text for add new subject
  ///
  /// In en, this message translates to:
  /// **'Add New Subject'**
  String get add_new_subject;

  /// Text for day-keep
  ///
  /// In en, this message translates to:
  /// **'Days in a row! Keep it up!'**
  String get day_keep;

  /// Text for progress
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// Text for edit profile
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// Text for edit profile description
  ///
  /// In en, this message translates to:
  /// **'Update your personal and academic information.'**
  String get edit_profile_desc;

  /// Text for personal information
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get personal_info;

  /// Text for academic information
  ///
  /// In en, this message translates to:
  /// **'Academic Information'**
  String get academic_information;

  /// Text for save changes
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get save_changes;

  /// Text for manage subscriptions
  ///
  /// In en, this message translates to:
  /// **'Manage Subscriptions'**
  String get manage_subscriptions;

  /// Text for subscriptions description
  ///
  /// In en, this message translates to:
  /// **'You can manage your subscriptions here'**
  String get subscriptions_desc;

  /// Text for edit account
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get edit_account;

  /// Text for upgrade to premium
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgrade_to_premium;

  /// Text for unlock all features
  ///
  /// In en, this message translates to:
  /// **'Unlock all features'**
  String get unlock_all_features;

  /// Text for general settings
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get general_settings;

  /// Text for notifications
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notfication;

  /// Text for appearance
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Text for language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Text for Achievements
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// Text for notification settings
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notification_settings;

  /// Text for Sound
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Text for Vibration
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// Text for study reminders
  ///
  /// In en, this message translates to:
  /// **'Study Reminders'**
  String get study_reminders;

  /// Text for Reminders
  ///
  /// In en, this message translates to:
  /// **'Exam Alerts'**
  String get exam_alerts;

  /// Text for account
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Text for privacy security title
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacy_security_title;

  /// Text for privacy security description
  ///
  /// In en, this message translates to:
  /// **'Password, 2FA'**
  String get privacy_security_desc;

  /// Text for study progress
  ///
  /// In en, this message translates to:
  /// **'Study Progress'**
  String get study_progress_title;

  /// Text for study progress description
  ///
  /// In en, this message translates to:
  /// **'85% completed this month'**
  String get study_progress_desc;

  /// Text for delete account
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account_title;

  /// Text for delete account description
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get delete_account_desc;

  /// Text for sign out
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out_title;

  /// Text for sign out description
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get sign_out_desc;

  /// Text for about
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Text for terms and conditions
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get term_and_conditions;

  /// Text for privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// Text for learn more
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learn_more;

  /// Text for contact us
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contact_us_title;

  /// Text for contact us description
  ///
  /// In en, this message translates to:
  /// **'Email, Phone'**
  String get contact_us_desc;

  /// Text for help center
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// Text for rate app
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rate_app;

  /// Text for app version
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get app_version;

  /// Text for system default
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get system_default_title;

  /// Text for system default description
  ///
  /// In en, this message translates to:
  /// **'Follow device settings'**
  String get system_default_desc;

  /// Text for light mode
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get light_mode_title;

  /// Text for light mode description
  ///
  /// In en, this message translates to:
  /// **'Bright and clean interface'**
  String get light_mode_desc;

  /// Text for dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode_title;

  /// Text for dark mode description
  ///
  /// In en, this message translates to:
  /// **'Easy on the eyes'**
  String get dark_mode_desc;

  /// Text for dark mode 2
  ///
  /// In en, this message translates to:
  /// **'Dark Mode 2'**
  String get dark_mode_two_title;

  /// Text for dark mode 2 description
  ///
  /// In en, this message translates to:
  /// **'Bright and clean interface'**
  String get dark_mode_two_desc;

  /// Text for theme settings
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get theme_setting;

  /// Text for theme settings description
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get theme_setting_desc;
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
      <String>['ar', 'en', 'es', 'fr'].contains(locale.languageCode);

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
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
