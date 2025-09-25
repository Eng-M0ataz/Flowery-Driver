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
          /// Background waves at bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: screenHeight/3,
              width: double.infinity,
              child: SvgPicture.asset(
                Assets.assetsImagesBg, // <-- your bg.svg
                fit: BoxFit.fill,
              ),
            ),
          ),

          /// Centered fixed-size content
          Center(
            child: SizedBox(
              width: 315,
              height: 382,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Big check icon
                  SvgPicture.asset(
                    Assets.assetsImagesVector,
                    width: 160,
                    height: 160,
                  ),

                  const SizedBox(height: AppSizes.spaceBetweenItems_16),

                  /// Title
                  Text(
                    LocaleKeys.applySuccess.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: AppSizes.spaceBetweenItems_12),

                  /// Description
                  Text(
                    LocaleKeys.applySuccessDescription.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),

                  const Spacer(),

                  /// Login Button
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
