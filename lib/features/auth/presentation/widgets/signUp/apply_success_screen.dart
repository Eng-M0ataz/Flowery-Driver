import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ApprovedAppScreen extends StatelessWidget {
  const ApprovedAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(Assets.assetsImagesBg, fit: BoxFit.cover),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLg_24,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: SvgPicture.asset(
                        Assets.assetsImagesVector,
                        fit: BoxFit.contain,
                        width: AppSizes.imageWidth_160,
                        height: AppSizes.imageHeight_160,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_24),
                    Text(
                      LocaleKeys.app_approved_title.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_12),
                    Text(
                      LocaleKeys.app_approved_desc.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColorsLight.grey,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusXxxl_32,
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.pushNamed(AppRoutes.signUpRoute);
                        },
                        child: Text(
                          LocaleKeys.login.tr(),
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
