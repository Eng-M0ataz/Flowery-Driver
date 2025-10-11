import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
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
      child: Column(
        spacing: AppSizes.spaceBetweenItems_16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.flowerOrder,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(Assets.assetsImagesCheckCircle),
              const SizedBox(width: AppSizes.spaceBetweenItems_4),
              Text(
                LocaleKeys.completed,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColorsLight.green,
                ),
              ),
              const Spacer(),
              Text(
                '#123456',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          Text(
            LocaleKeys.pickupAddress,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColorsLight.grey,
            ),
          ),
          const AddressCard(),
          Text(
            LocaleKeys.userAddress,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColorsLight.grey,
            ),
          ),
          const AddressCard(),
        ],
      ),
    );
  }
}
