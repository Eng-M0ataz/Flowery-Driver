import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      child: ListView(
        children: [
          Text(
            LocaleKeys.welcome.tr(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
          Text(
            LocaleKeys.join_team.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: AppColorsLight.grey),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_32),
          const SignUpForm(),
        ],
      ),
    );
  }
}
