import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadiusMd_10,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColorsLight.grey.withValues(alpha: 0.4),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.paddingSm_8),
      child: Row(
        spacing: AppSizes.spaceBetweenItems_8,
        children: [
          const CircleAvatar(radius: AppSizes.borderRadiusXxl_24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.floweryStore.tr(),
                style: Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: AppColorsLight.grey),
              ),
              const SizedBox(
                height: AppSizes.spaceBetweenItems_8,
              ),
              Row(
                spacing: AppSizes.spaceBetweenItems_4,
                children: [
                  SvgPicture.asset(Assets.assetsImagesLocation),
                  Text(
                    LocaleKeys.floweryStore.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
