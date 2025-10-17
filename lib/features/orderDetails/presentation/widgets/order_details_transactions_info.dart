import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailsTransactioninfo extends StatelessWidget {
  const OrderDetailsTransactioninfo({
    super.key,
    required this.name,
    required this.data,
  });
  final String name;
  final String data;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm_8,
        vertical: AppSizes.paddingMd_16,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.paddingMd_16),
        boxShadow: [BoxShadow(color: AppColorsLight.white[60]!, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: theme.textTheme.headlineMedium),
          Text(
            data,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColorsLight.grey,
            ),
          ),
        ],
      ),
    );
  }
}
