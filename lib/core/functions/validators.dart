import 'package:flowery_tracking/core/helpers/regex.dart';

abstract class Validations {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required!';
    } else if (!AppRegExp.isNameValid(name.trim())) {
      return 'This Name is not valid';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required!';
    } else if (!AppRegExp.isEmailValid(email.trim())) {
      return 'This Email is not valid';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required!';
    } else if (!AppRegExp.isPasswordValid(password)) {
      return 'This Password is not valid';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required!';
    } else if (!AppRegExp.isPasswordValid(confirmPassword)) {
      return 'This Confirm Password is not valid';
    } else if (password != confirmPassword) {
      return 'Password and Confirm Password must be same!';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Phone number is required!';
    } else if (!AppRegExp.isPhoneNumberValid(phoneNumber.trim())) {
      return 'This Phone number is not valid';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address == null || address.trim().isEmpty) {
      return 'Address is required!';
    } else if (address.trim().length < 5) {
      return 'Address is too short';
    } else if (address.trim().length > 100) {
      return 'Address is too long';
    }
    return null;
  }

  static String? validateCity(String? city) {
    if (city == null || city.trim().isEmpty) {
      return 'Please select a city';
    }
    return null;
  }

  static String? pinCodeValidator(String? val) {
    if (val!.length < 6) {
      return 'Please enter all digits';
    } else {
      return null;
    }
  }

  static String? validateRecipientName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Recipient name is required!';
    }

    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) {
      return 'Please enter full name (first and last name)';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      return 'Name can only contain letters';
    }

    return null;
  }
}
