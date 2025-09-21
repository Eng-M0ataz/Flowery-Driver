import 'package:flutter/material.dart';

void showSnackBar(
    {required String message,
    required BuildContext context,
    required TextStyle textStyle,
    Color? backgroundColor,
    Duration? duration}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(
    duration: duration ?? const Duration(seconds: 2),
    content: Text(
      message,
      style: textStyle,
    ),
    backgroundColor: backgroundColor,
  ));
}
