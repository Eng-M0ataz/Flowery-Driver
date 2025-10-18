import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.ordersNumbers,
    required this.status,
    required this.iconPath,
  });

  final int ordersNumbers;
  final String status;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.paddingSm_8,
        horizontal: AppSizes.paddingMd_16,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.spaceBetweenItems_16,
      ),
      decoration: BoxDecoration(
        color: AppColorsLight.pink[10]?.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
      ),
      child: Column(
        spacing: AppSizes.spaceBetweenItems_8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$ordersNumbers',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Row(
            spacing: AppSizes.spaceBetweenItems_2,
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: AppSizes.spaceBetweenItems_8),
              Text(status, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ],
      ),
    );
  }
}
