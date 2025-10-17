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
  static const int ordersPageLimit = 10;
  static const int uiRebuildDelay = 100;
  static const String inProgress = 'inProgress';
  static const String apiRemoteExecutor = 'apiRemoteExecutor';
  static const String firebaseRemoteExecutor = 'firebaseRemoteExecutor';
  static const String firebaseRealTimeDatabase = 'firebaseRealTimeDatabase';
  static const String orderDetailsTimeAndDateFormat =
      'EEE, dd MMM yyyy, hh:mm a';
  static const String orderCompleted = 'completed';
}
