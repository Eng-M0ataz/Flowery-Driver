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
  static const int ordersPageLimit = 10;
  static const int uiRebuildDelay = 100;
  static const String inProgress = 'inProgress';
  static const String apiRemoteExecutor = 'apiRemoteExecutor';
  static const String firebaseRemoteExecutor = 'firebaseRemoteExecutor';
  static const String firebaseRealTimeDatabase = 'firebaseRealTimeDatabase';
  static const String orderDetailsTimeAndDateFormat =
      'EEE, dd MMM yyyy, hh:mm a';
  static const String orderCompleted = 'completed';
  static const String male = 'male';
  static const String female = 'female';
  static const String femaleValue = 'Female';
  static const int imageQuality = 80;
  static const String chatgpt = 'chatgpt';
  static const String gemini = 'gemini';
  static const String imageDataType = 'image/jpeg';
  static const String vehicleMapPath = 'assets/vehicle_types.json';
  static const String aiValidationPrompt =
      'You are an AI system that verifies identity documents. The user will upload an image. Your task: If the image is a valid, complete, government-issued driver’s license, national ID card, or passport → respond with: valid. Otherwise → respond with: invalid. Rules: Be strict. Do NOT accept selfies, random photos, or unofficial documents. If the image is blurry, cropped, or incomplete → respond with: invalid. Respond with only one word: valid or invalid.';

  static const String obscuringCharacter = '★';
  static const String geminiModel = 'gemini-2.5-flash-lite';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const String imagePath =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkAJEkJQ1WumU0hXNpXdgBt9NUKc0QDVIiaw&s';
}
