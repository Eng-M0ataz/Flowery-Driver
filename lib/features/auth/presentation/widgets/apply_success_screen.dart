import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplySuccessScreen extends StatelessWidget {
  const ApplySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight/3,
              width: double.infinity,
              child: SvgPicture.asset(
                Assets.assetsImagesBg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: AppSizes.widgetWidth_315,
              height: AppSizes.widgetHeight_382,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.assetsImagesVector,
                    width: AppSizes.imageWidth_160,
                    height: AppSizes.imageHeight_160,
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_16),
                  Text(
                    LocaleKeys.applySuccess.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.xlFont_20,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_12),
                  Text(
                    LocaleKeys.applySuccessDescription.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      fontSize: AppSizes.mdFont_16,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      isLoading: false,
                      onPressed: () => context.pushReplacementNamed(
                        AppRoutes.signInRoute,
                      ),
                      widget: Text(LocaleKeys.login.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}