import 'package:flowery_tracking/core/utils/constants/device_type.dart';
import 'package:responsive_framework/responsive_framework.dart';

abstract class AppSizes {
  // padding and margin sizes
  static const double paddingXs_4 = 4.0;
  static const double paddingSm_8 = 8.0;
  static const double paddingSm_12 = 12.0;
  static const double paddingMd_10 = 10.0;
  static const double paddingMd_12 = 12.0;
  static const double paddingMd_16 = 16.0;
  static const double paddingMd_20 = 20.0;
  static const double paddingLg_24 = 24.0;
  static const double paddingXl_32 = 32.0;
  static const double paddingXl_64 = 64.0;

  // icon sizes

  static const double icon_8 = 8.0;
  static const double icon_12 = 12.0;
  static const double icon_16 = 16.0;
  static const double icon_18 = 18.0;
  static const double icon_24 = 24.0;
  static const double icon_30 = 30.0;
  static const double icon_32 = 32.0;
  static const double icon_36 = 36.0;
  static const double icon_60 = 60.0;
  static const double icon_64 = 64.0;
  static const double icon_120 = 120.0;

  // font sizes
  static const double font_10 = 10.0;
  static const double xsFont_12 = 12.0;
  static const double xsFont_13 = 13.0;
  static const double smFont_14 = 14.0;
  static const double mdFont_16 = 16.0;
  static const double lgFont_18 = 18.0;
  static const double xlFont_20 = 20.0;
  static const double xxlFont_22 = 22.0;
  static const double xxlFont_24 = 24.0;

  // button sizes

  static const double buttonHigh_48 = 48;
  static const double buttonHigh_36 = 36;
  static const double buttonWidth_80 = 80;

  // AppBar High

  static const double appBarHigh = 56.0;
  static const double appBarElevation = 0.0;
  static const double appBarLeadingWidth = 300.0;

  // Default Spacing Between items
  static const double spaceBetweenItems_2 = 2.0;
  static const double spaceBetweenItems_4 = 4.0;
  static const double spaceBetweenItems_6 = 6.0;
  static const double spaceBetweenItems_8 = 8.0;
  static const double spaceBetweenItems_10 = 10.0;
  static const double spaceBetweenItems_12 = 12.0;
  static const double spaceBetweenItems_16 = 16.0;
  static const double spaceBetweenItems_20 = 20.0;
  static const double spaceBetweenItems_24 = 24.0;
  static const double spaceBetweenItems_32 = 32.0;
  static const double spaceBetweenItems_36 = 36.0;
  static const double spaceBetweenItems_40 = 40.0;
  static const double spaceBetweenItems_42 = 42.0;
  static const double spaceBetweenItems_44 = 44.0;
  static const double spaceBetweenItems_48 = 48.0;
  static const double spaceBetweenItems_50 = 50.0;

  // Default Spacing Between Sections

  static const double spaceBetweenSections_16 = 16.0;

  // Border Radius

  static const double borderRadius0 = 0.0;
  static const double borderRadiusXs_2 = 2.0;
  static const double borderRadiusSm_4 = 4.0;
  static const double borderRadiusMd_8 = 8.0;
  static const double borderRadiusMd_10 = 10.0;
  static const double borderRadiusLg_12 = 12.0;
  static const double borderRadiusXl_16 = 16.0;
  static const double borderRadiusXl_20 = 20.0;
  static const double borderRadiusXxl_24 = 24.0;
  static const double borderRadiusXxxl_32 = 32.0;
  static const double borderRadiusXxxl_40 = 32.0;
  static const double borderRadiusFull = 100.0;

  //Border Width
  static const double borderWidth_1 = 1.0;
  static const double borderWidth_2 = 2.0;
  static const double borderWidth_3 = 3.0;
  static const double borderWidth_4 = 4.0;

  // Divider Height

  static const double dividerHeight = 1.0;

  // grid view spacing

  static const double gridSpacing = 16.0;

  //size box sizes
  static const double sizedBoxWidth_8 = 8.0;
  static const double sizedBoxWidth_16 = 16.0;
  static const double sizedBoxHeight_8 = 8.0;
  static const double sizedBoxHeight_16 = 16.0;
  static const double sizedBoxHeight_30 = 30.0;

  // break points

  static const List<Breakpoint> appBreakPoints = [
    Breakpoint(start: 0, end: 450, name: DeviceType.mobile),
    Breakpoint(start: 451, end: 800, name: DeviceType.tablet),
    Breakpoint(start: 801, end: 1920, name: DeviceType.desktop),
  ];
  static const List<Breakpoint> appLandscapeBreakPoints = [
    Breakpoint(start: 0, end: 1023, name: DeviceType.mobile),
    Breakpoint(start: 1024, end: 1599, name: DeviceType.tablet),
    Breakpoint(start: 1600, end: double.infinity, name: DeviceType.desktop),
  ];

  static const List<Condition<double>> conditionalValues = [
    Condition.between(start: 0, end: 450, value: 375),
    Condition.between(start: 451, end: 768, value: 600),
    Condition.between(start: 769, end: 1024, value: 1024),
  ];

  //pin code
  static const int pinCodeLength_6 = 6;
  static const double pinCodeHeight_74 = 74;
  static const double pinCodeWidth_68 = 68;
  static const int pinCodeSpace = 16;
  static const double pinCodeBorderWidth_2=2;
}
