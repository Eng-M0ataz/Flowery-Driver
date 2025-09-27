import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/config/theme/app_theme.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_button.dart';
import 'package:flowery_tracking/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSm_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(Assets.assetsImagesGroup, fit: BoxFit.scaleDown,),
              const SizedBox(height: AppSizes.spaceBetweenItems_8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSm_8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.welcome_to_flowery_rider_app.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSizes.sizedBoxHeight_27,),
                    CustomButton(
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_16),
                      onPressed: () {
                        context.pushNamed(AppRoutes.signInRoute);
                      },
                      borderRadius: AppSizes.borderRadiusFull,
                      child: Text(
                        LocaleKeys.login.tr(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColorsLight.white),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_16,),
                    CustomButton(
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_16),
                      onPressed: () {
                        context.pushNamed(AppRoutes.signUpRoute);
                      },
                      borderRadius: AppSizes.borderRadiusFull,
                      backgroundColorButton: AppColorsLight.white,
                      borderSide: const BorderSide(width: 1,color: AppColorsLight.black),
                      child: Text(
                          LocaleKeys.apply_now.tr(), style: Theme.of(context).textTheme.labelLarge
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(LocaleKeys.version, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        ),
      ),
    );
  }
}
