import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({super.key,this.onTap ,required this.leading, required this.trailing, required this.title});
  final IconData leading;
  final IconData trailing;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.paddingLg_24, bottom: AppSizes.paddingSm_8),
      child: Row(
        spacing: AppSizes.spaceBetweenItems_4,
        children: [
          Icon(leading, size: AppSizes.icon_18,),
          Text(title, style: Theme.of(context).textTheme.labelSmall,),
          const Spacer(),
          IconButton(onPressed: onTap , icon: Icon(trailing, size: AppSizes.icon_24,),)
        ],
      ),
    );
  }
}
