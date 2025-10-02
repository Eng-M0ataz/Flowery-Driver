import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  required String message,

  Color? color,
  Duration? duration,
}) {
  final snackBar = SnackBar(
    duration: duration ?? const Duration(seconds: 4),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.only(
      bottom:
          MediaQuery.of(context).size.height - AppSizes.spaceBetweenItems_170,
      left: AppSizes.paddingMd_12,
      right: AppSizes.paddingMd_12,
    ),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.warning,
      color: color,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
