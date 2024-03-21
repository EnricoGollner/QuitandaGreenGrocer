import 'package:get/get.dart';

class Validators {
  static String? isRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? isFullname(String? value) {
    String? message = isRequired(value);
    if (message != null) return message;

    if (value!.trim().split(' ').length == 1) {
      return 'Please enter your full name';
    }
    return null;
  }

  static String? isPhone(String? value) {
    String? message = isRequired(value);
    if (message != null) return message;

    if (value!.length < 14 || !value.isPhoneNumber) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? isEmail(String? value) {
    String? message = isRequired(value);
    if (message != null) return message;

    if (!value!.isEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? isPasswordGreaterThan7Char(String? value) {
    String? message = isRequired(value);
    if (message != null) return message;

    if (value!.length < 7) {
      return 'Password must be at least 7 characters';
    }
    return null;
  }

  static String? isCPF(String? value) {
    String? message = isRequired(value);
    if (message != null) return message;

    if (!value!.isCpf) {
      return 'Please enter a valid CPF';
    }
    return null;
  }
}