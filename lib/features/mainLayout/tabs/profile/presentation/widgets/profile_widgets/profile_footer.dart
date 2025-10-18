import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key,this.onTap ,required this.leading, this.trailing, required this.title, required this.isIconBtn});
  final IconData leading;
  final IconData? trailing;
  final String title;
  final bool isIconBtn;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingXs_4),
      child: Row(
        spacing: AppSizes.spaceBetweenItems_4,
        children: [
          Icon(leading, size: AppSizes.icon_18,),
          Text(title, style: Theme.of(context).textTheme.labelSmall,),
          const Spacer(),
          isIconBtn ?  IconButton(onPressed: onTap , icon: Icon(trailing, size: AppSizes.icon_24,),):
          TextButton(onPressed: onTap, child:  Text(LocaleKeys.english.tr(),),),
        ],
      ),
    );
  }
}
