import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/helpers/app_config_cubit.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Divider(
              color: AppColorsLight.black,
              thickness: 4,
              indent: 120,
              endIndent: 120,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          Text(
            LocaleKeys.language.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          _buildLanguageTile(
            context: context,
            title: LocaleKeys.arabic.tr(),
            locale: const Locale(AppConstants.ar),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          _buildLanguageTile(
            context: context,
            title: LocaleKeys.english.tr(),
            locale: const Locale(AppConstants.en),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String title,
    required Locale locale,
  }) {
    return BlocBuilder<AppConfigCubit, Locale>(
      builder: (context, currentLocale) {
        final isSelected = currentLocale.languageCode == locale.languageCode;

        return Material(
          elevation: 2,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
          child: ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSizes.borderRadiusMd_8),
              ),
            ),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            tileColor: AppColorsLight.white,
            trailing: isSelected
                ? SvgPicture.asset(
                    Assets.assetsImagesSelectedIcon,
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  )
                : SvgPicture.asset(
                    Assets.assetsImagesIcon,
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
            onTap: () {
              context.read<AppConfigCubit>().changeLanguage(locale);
              context.setLocale(locale);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
