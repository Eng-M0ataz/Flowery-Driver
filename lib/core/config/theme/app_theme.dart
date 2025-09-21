import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/config/theme/text_them.dart';
import 'package:flowery_tracking/core/utils/constants/app_fonts.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

abstract class AppThemeLight {
  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColorsLight.white,
        foregroundColor: AppColorsLight.black,
        elevation: AppSizes.appBarElevation,
        titleTextStyle: TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: AppSizes.xlFont_20,
          fontWeight: FontWeight.w500,
          color: AppColorsLight.black,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.xsFont_12,
          fontFamily: AppFonts.inter,
          color: AppColorsLight.pink,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.xsFont_12,
          fontFamily: AppFonts.inter,
          color: AppColorsLight.white[80],
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColorsLight.white[70],
        thickness: 1,
      ),
      tabBarTheme: (TabBarThemeData(
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.only(right: AppSizes.paddingLg_24),
        labelColor: colorScheme.primary,
        unselectedLabelColor: AppColorsLight.white[70],
        indicatorColor: colorScheme.primary,
        dividerColor: colorScheme.onPrimary,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.mdFont_16,
          fontFamily: AppFonts.inter,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.mdFont_16,
          fontFamily: AppFonts.inter,
        ),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.pink,
          foregroundColor: AppColorsLight.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusFull),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.mdFont_16,
            fontFamily: AppFonts.inter,
            color: AppColorsLight.white,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppSizes.mdFont_16,
            fontFamily: AppFonts.inter,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.xsFont_12,
          fontFamily: AppFonts.roboto,
          color: AppColorsLight.red,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.smFont_14,
          fontFamily: AppFonts.roboto,
          color: AppColorsLight.white[70],
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.xsFont_12,
          fontFamily: AppFonts.roboto,
          color: AppColorsLight.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          borderSide: const BorderSide(color: AppColorsLight.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          borderSide: const BorderSide(color: AppColorsLight.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          borderSide: const BorderSide(color: AppColorsLight.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          borderSide: const BorderSide(color: AppColorsLight.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
          borderSide: const BorderSide(color: AppColorsLight.red),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColorsLight.pink[70],
      ),
      textTheme: textTheme,
    );
  }

  static ThemeData lightTheme = getTheme(
    const ColorScheme(
      brightness: Brightness.light,
      primary: AppColorsLight.pink,
      onPrimary: AppColorsLight.white,
      secondary: AppColorsLight.green,
      onSecondary: AppColorsLight.white,
      surface: AppColorsLight.white,
      onSurface: AppColorsLight.black,
      error: AppColorsLight.red,
      onError: AppColorsLight.white,
    ),
  );
}
