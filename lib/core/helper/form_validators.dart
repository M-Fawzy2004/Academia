class FormValidators {
  // Username validator
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }
    // Check if username contains only letters, numbers, and underscores
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  // Email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    // Basic email regex pattern
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (value.length > 50) {
      return 'Password must be less than 50 characters';
    }
    // Check if password contains at least one letter and one number
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one letter and one number';
    }
    return null;
  }

  // Confirm password validator
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please enter confirm password';
    }
    if (value != password) {
      return 'Passwords do not match';
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

  // Phone number validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    // Egyptian phone number pattern (example)
    if (!RegExp(r'^(010|011|012|015)\d{8}$').hasMatch(value)) {
      return 'Please enter a valid Egyptian phone number';
    }
    return null;
  }

  // Name validator (first name, last name)
  static String? validateName(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Please enter ${fieldName ?? 'name'}';
    }
    if (value.length < 2) {
      return '${fieldName ?? 'Name'} must be at least 2 characters';
    }
    if (value.length > 50) {
      return '${fieldName ?? 'Name'} must be less than 50 characters';
    }
    // Check if name contains only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '${fieldName ?? 'Name'} can only contain letters and spaces';
    }
    return null;
  }

  // Age validator
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter age';
    }
    int? age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid age';
    }
    if (age < 13) {
      return 'Age must be at least 13';
    }
    if (age > 120) {
      return 'Please enter a valid age';
    }
    return null;
  }
}
