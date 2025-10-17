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
  static const String chatgpt = 'chatgpt';
  static const String gemini = 'gemini';
  static const String imageDataType = 'image/jpeg';
  static const String vehicleMapPath = 'assets/vehicle_types.json';
  static const String aiValidationPrompt =
      'You are an AI system that verifies identity documents. The user will upload an image.Your task:- If the image is a valid government-issued driver’s license, national ID card, or passport → respond with: VALID- Otherwise → respond with: INVALIDRules:- Be strict. Do not accept selfies, random photos, or unofficial documents.- If the image is blurry, cropped, or incomplete → respond with: INVALIDRespond with only one word: valid or invalid.';
  static const String obscuringCharacter = '★';
  static const String geminiModel = 'gemini-2.5-flash-lite';
 static const int ordersPageLimit = 10;
  static const int uiRebuildDelay=100;
static const String inProgress='inProgress';
}
