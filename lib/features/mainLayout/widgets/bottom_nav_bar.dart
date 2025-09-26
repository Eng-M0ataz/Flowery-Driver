import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onChanged,
      items: [
        BottomNavigationBarItem(
          label: LocaleKeys.home.tr(),
          activeIcon: SvgPicture.asset(Assets.assetsImagesHomeSelected),
          icon: SvgPicture.asset(Assets.assetsImagesHomeUnselected),
        ),
        BottomNavigationBarItem(
          label: LocaleKeys.orders.tr(),
          activeIcon: SvgPicture.asset(Assets.assetsImagesFactCheck2),
          icon: SvgPicture.asset(Assets.assetsImagesFactCheck),
        ),
        BottomNavigationBarItem(
          label: LocaleKeys.profile.tr(),
          activeIcon: SvgPicture.asset(Assets.assetsImagesPersonSelected),
          icon: SvgPicture.asset(Assets.assetsImagesPersonUnselected),
        ),
      ],
    );
  }
}
