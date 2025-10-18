import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PaymentData extends StatelessWidget {
  const PaymentData({super.key, required this.title, required this.paymentMethod});
  final String title;
  final String paymentMethod;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
        boxShadow: [
          BoxShadow(
            color: AppColorsLight.grey.withValues(alpha: 0.4),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_12),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSm_8, vertical: AppSizes.paddingMd_16),
      child: Row(
        spacing: AppSizes.spaceBetweenItems_8,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium,
          ),
          const Spacer(),
          Text(
            paymentMethod,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColorsLight.grey),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
