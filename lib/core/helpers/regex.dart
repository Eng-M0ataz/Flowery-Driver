abstract class AppRegExp {
  static bool isNameValid(String name) {
    return RegExp(r'^[A-Za-z]{2,}$').hasMatch(name);
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    return RegExp(r'^(?:\+20|20)?(?:0)?1[0125][0-9]{8}$').hasMatch(cleaned);
  }

  static bool isOTPValid(String otp) {
    return RegExp(r'^[0-9]{6}$').hasMatch(otp);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
    ).hasMatch(password);
  }
}
