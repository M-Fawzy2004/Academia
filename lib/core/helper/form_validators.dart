import 'package:flutter/widgets.dart';
import 'package:study_box/core/helper/translate.dart';

class FormValidators {
  // Username validator
  static String? validateUsername(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_username;
    }
    if (value.length < 3) {
      return context.tr.username_3_characters;
    }
    if (value.length > 20) {
      return context.tr.username_20_characters;
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return context.tr.username_letters_numbers_underscores;
    }
    return null;
  }

  // Email validator
  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_email;
    }
    // Basic email regex pattern
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return context.tr.valid_email_address;
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_password;
    }
    if (value.length < 6) {
      return context.tr.password_6_chars_minimum;
    }
    if (value.length > 50) {
      return context.tr.password_50_chars_maximum;
    }
    // Check if password contains at least one letter and one number
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
      return context.tr.password_letter_number;
    }
    return null;
  }

  // Confirm password validator
  static String? validateConfirmPassword(
      String? value, String? password, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_confirm_password;
    }
    if (value != password) {
      return context.tr.email_not_found;
    }
    return null;
  }

  // Generic required field validator
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Please enter ${fieldName ?? 'this field'}';
    }
    return null;
  }

  // Name validator (first name, last name)
  static String? validateName(BuildContext context, String? value,
      {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_name;
    }
    if (value.length < 2) {
      return context.tr.name_2_characters;
    }
    if (value.length > 50) {
      return context.tr.name_50_characters;
    }
    // Check if name contains only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return context.tr.name_letters_spaces;
    }
    return null;
  }

  // Age validator
  static String? validateAge(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.tr.please_enter_age;
    }
    int? age = int.tryParse(value);
    if (age == null) {
      return context.tr.valid_age;
    }
    if (age < 13) {
      return context.tr.age_minimum_13;
    }
    return null;
  }

  // Helper methods that return validator functions
  static String? Function(String?) emailValidator(BuildContext context) {
    return (String? value) => validateEmail(value, context);
  }

  static String? Function(String?) passwordValidator(BuildContext context) {
    return (String? value) => validatePassword(value, context);
  }

  static String? Function(String?) usernameValidator(BuildContext context) {
    return (String? value) => validateUsername(value, context);
  }

  static String? Function(String?) nameValidator(BuildContext context,
      {String? fieldName}) {
    return (String? value) =>
        validateName(context, value, fieldName: fieldName);
  }

  static String? Function(String?) ageValidator(BuildContext context) {
    return (String? value) => validateAge(value, context);
  }

  static String? Function(String?) confirmPasswordValidator(
      BuildContext context, String password) {
    return (String? value) => validateConfirmPassword(value, password, context);
  }
}
