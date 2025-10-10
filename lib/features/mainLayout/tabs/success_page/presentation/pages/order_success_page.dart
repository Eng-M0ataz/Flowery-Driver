import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                child:SvgPicture.asset(
                  AppConstants.orderSuccessImage,
                  fit: BoxFit.contain,
                  width: AppSizes.imageOrderSuccessWidth_150,
                  height: AppSizes.imageOrderSuccessHeight_150,
                ) ,
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
               Text(
                  LocaleKeys.thank_you.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColorsLight.green,
                    fontSize: AppSizes.xxlFont_24
                  )
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_12),
               Text(
                LocaleKeys.order_successful_desc.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: AppSizes.xxlFont_24
                )
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_32),
              SizedBox(
                width: AppSizes.buttonWidth_343,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxxl_32),
                    ),
                  ),
                  onPressed: () {},
                  child:  Text(
                    LocaleKeys.done.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}