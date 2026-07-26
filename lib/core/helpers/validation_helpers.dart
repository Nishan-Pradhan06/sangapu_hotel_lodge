class InputValidator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your name';
    } else if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    } else if (value.trim().length > 50) {
      return 'Name must not exceed 50 characters';
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    } else if (RegExp(r"\s{2,}").hasMatch(value.trim())) {
      return 'Name cannot contain multiple spaces in a row';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your phone number';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Phone number must be exactly 10 digits';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email';
    } else if (!RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your confirm your password';
    } else if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email or phone number';
    }

    final isEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final isPhone = RegExp(r'^\d{10}$');

    if (!isEmail.hasMatch(value.trim()) && !isPhone.hasMatch(value.trim())) {
      return 'Enter a valid email or 10-digit phone number';
    }

    return null;
  }

  /// Checkbox validation
  /// Pass the boolean value of the checkbox (true if checked)
  static String? validateCheckbox(bool? value) {
    if (value == null || !value) {
      return 'You must accept the Terms of Service';
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a description';
    } else if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    } else if (value.trim().length > 500) {
      return 'Description must not exceed 500 characters';
    } else if (RegExp(r"\s{3,}").hasMatch(value)) {
      return 'Description contains too many spaces';
    }
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter the OTP code';
    } else if (value.trim().length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }
}
