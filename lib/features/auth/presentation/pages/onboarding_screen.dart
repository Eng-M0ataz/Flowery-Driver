import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  late final SignInViewModel _viewModel;

  @override
  void initState() {
    _viewModel = getIt<SignInViewModel>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSm_10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(Assets.assetsImagesGroup, fit: BoxFit.scaleDown),
                const SizedBox(height: AppSizes.spaceBetweenItems_8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSm_8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.welcome_to_flowery_rider_app.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSizes.sizedBoxHeight_27),
                      CustomElevatedButton(
                        onPressed: () { _viewModel.doIntent(event: NavigationEvent(context: context, appRoute: AppRoutes.signInRoute));},
                        isLoading: false,
                        widget: Text(
                          LocaleKeys.login.tr(),
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColorsLight.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_16),
                      Theme(
                        data: ThemeData(
                          elevatedButtonTheme: ElevatedButtonThemeData(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.onPrimary,
                              foregroundColor: Theme.of(context).colorScheme.onSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSizes.borderRadiusFull),
                                side: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurface)
                              ),
                            )
                          )
                        ),
                        child: CustomElevatedButton(
                          onPressed: () {
                            _viewModel.doIntent(event: NavigationEvent(context: context, appRoute: AppRoutes.signUpRoute));
                          },
                          isLoading: false,
                          widget: Text(
                            LocaleKeys.apply_now.tr(),
                            style: Theme.of(context).textTheme.labelLarge
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
