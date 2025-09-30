import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_edit_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_footer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBetweenItems_6),
            ProfileAppBar(onTap: (){},),
            ProfileEditCard(
              onTap: () {},
              hasImage: true,
              title: 'Abdelrahman',
              subtitle: 'subtitle',
              vehicleOrPhoneNumber: 'phone number',
            ),
            ProfileEditCard(
              onTap: () {},
              hasImage: false,
              title: 'Abdelrahman',
              subtitle: 'subtitle',
              vehicleOrPhoneNumber: 'phone number',
            ),
            ProfileFooter(onTap: (){},trailing: Icons.language,title: LocaleKeys.language.tr(),leading: Icons.translate, isIconBtn: false,),
            ProfileFooter(onTap: (){},trailing: Icons.logout,title: LocaleKeys.logout.tr(),leading: Icons.logout,isIconBtn: true,),

          ],
        ),
      ),
    );
  }
}
