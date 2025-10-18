import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Row(
      spacing: AppSizes.spaceBetweenItems_6,
      children: [
        const Icon(Icons.arrow_back_ios_new, size: AppSizes.icon_24),
        Text(
          LocaleKeys.profile.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          icon: const Badge(
            label: Text('3'),
            textColor: AppColorsLight.white,
            alignment: Alignment.topRight,
            backgroundColor: AppColorsLight.red,
            child: Icon(
              Icons.notifications_outlined,
              size: AppSizes.icon_30,
            ),
          ),
        ),
      ],
    );
  }
}
