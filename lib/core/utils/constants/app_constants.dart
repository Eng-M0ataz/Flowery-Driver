import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];
  static const String languageCode = 'language_code';
  static const String secureStorage = 'secureStorage';
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'assets/translations';
  static const String token = 'token';
  static const String rememberMe = 'remember_me';
  static const String passwordCharacters = '★★★★★★';
  static const String gender = 'gender';
  static const String male = 'male';
  static const String female = 'female';
  static const String femaleValue = 'Female';
  static const int imageQuality = 80;
}
