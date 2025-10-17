import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomHomeElevatedButton extends StatelessWidget {
  const CustomHomeElevatedButton({
    super.key,
    required this.title,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.textColor,
  });

  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: AppSizes.padding_100,
      height: AppSizes.padding_36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.onPrimary,
          side: BorderSide(color: borderColor ?? theme.colorScheme.primary),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: theme.textTheme.displayLarge!.copyWith(
            color: textColor ?? theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
