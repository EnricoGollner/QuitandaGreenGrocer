import 'package:get/get.dart';

class Validators {
  static String? isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.isEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? isPasswordGreaterThan7Char(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters';
    }
    return null;
  }
}