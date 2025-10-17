import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_widgets/middle_ellipsis_text.dart';
import 'package:flutter/material.dart';

class VehicleEditCard extends StatelessWidget {
  const VehicleEditCard({
    super.key,
    this.onTap,

    required this.vehicleType,
    required this.vehicleNumber,
  });


  final void Function()? onTap;
  final String vehicleType;
  final String vehicleNumber;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBetweenItems_16,
        ),
        padding: const EdgeInsets.all(AppSizes.paddingMd_16),
        width: double.infinity,
        height: height * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: AppColorsLight.grey.withValues(alpha: 0.3),
              blurRadius: AppSizes.borderRadiusXs_2,
              offset: const Offset(0, 0),
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Row(
          spacing: AppSizes.spaceBetweenItems_16,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing:AppSizes.spaceBetweenItems_8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( LocaleKeys.vehicleInfo.tr(), style: Theme.of(context).textTheme.displaySmall),
                MiddleEllipsisText(text: vehicleType),
                MiddleEllipsisText(text: vehicleNumber),
                ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
