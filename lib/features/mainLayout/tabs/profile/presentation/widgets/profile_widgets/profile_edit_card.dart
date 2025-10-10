import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileEditCard extends StatelessWidget {
  const ProfileEditCard({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.vehicleOrPhoneNumber,
    this.imagePath,
  });


  final String? imagePath;
  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String vehicleOrPhoneNumber;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBetweenItems_16,
        ),
        padding: const EdgeInsets.all(AppSizes.paddingMd_16),
        width: double.infinity,
        height: height * 0.14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: AppColorsLight.grey.withValues(alpha: 0.3),
              blurRadius: AppSizes.borderRadiusXs_2,
              offset: const Offset(0, 0),
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Row(
          spacing: AppSizes.spaceBetweenItems_16,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imagePath == null ? Container() : CircleAvatar(backgroundImage: NetworkImage(imagePath!),radius: AppSizes.borderRadiusXxxl_32),
            Column(
              spacing:AppSizes.spaceBetweenItems_8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.displaySmall),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(vehicleOrPhoneNumber, style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            const Expanded(child: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}
