import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddressInfoCard extends StatelessWidget {
  const AddressInfoCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
  });

  final String imageUrl;
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSm_8),

      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.paddingMd_16),
        boxShadow: [
          BoxShadow(
            color: AppColorsLight.white[60]!,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.circleAvatarRadius_22,
            backgroundColor: AppColorsLight.white[60],
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: AppSizes.imageProfileWidth_80,
                height: AppSizes.imageProfileHeight_80,
                placeholder: (context, url) => const Icon(
                  Icons.person,
                  size: AppSizes.icon_36,
                  color: AppColorsLight.grey,
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: AppSizes.icon_36,
                  color: AppColorsLight.red,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSizes.spaceBetweenItems_8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                Text(
                  name,
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: AppColorsLight.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.assetsImagesLocation),
                    const SizedBox(width: AppSizes.spaceBetweenItems_4),
                    Expanded(
                      child: Text(
                        location,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: AppColorsLight.black,
                        ),
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
