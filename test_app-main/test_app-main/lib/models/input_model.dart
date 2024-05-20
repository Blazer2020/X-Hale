class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null; // Return null if the input is valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for at least one uppercase letter
    final uppercaseRegex = RegExp(r'[A-Z]');
    if (!uppercaseRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    // Check for at least one lowercase letter
    final lowercaseRegex = RegExp(r'[a-z]');
    if (!lowercaseRegex.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    // Check for at least one digit
    final digitRegex = RegExp(r'\d');
    if (!digitRegex.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    // Check for at least one special character
    final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharacterRegex.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Return null if the input is valid
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    final nameRegex = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null; // Return null if the input is valid
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null; // Return null if the input is valid
  }
}
