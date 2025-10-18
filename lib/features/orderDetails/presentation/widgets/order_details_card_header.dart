import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSizes.paddingMd_16,
        right: AppSizes.paddingMd_16,
        bottom: AppSizes.paddingMd_16,
        top: AppSizes.paddingLg_24,
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
