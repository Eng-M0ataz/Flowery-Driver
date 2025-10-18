import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderStateWidget extends StatelessWidget {
  const OrderStateWidget({
    super.key,
    required this.orderNumber,
    required this.state,
  });

  final String orderNumber;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          state == AppConstants.completed
              ? Assets.assetsImagesCheckCircle
              : Assets.assetsImagesCancel,
        ),
        const SizedBox(width: AppSizes.spaceBetweenItems_4),
        state == AppConstants.completed
            ? Text(
                LocaleKeys.completed.tr(),
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColorsLight.green),
              )
            : Text(
                LocaleKeys.cancelled.tr(),
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColorsLight.red),
              ),
        const Spacer(),
        Text(orderNumber, style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }
}
