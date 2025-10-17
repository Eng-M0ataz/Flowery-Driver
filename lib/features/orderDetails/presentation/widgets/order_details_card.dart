import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({super.key, required this.product});
  final ProductInfo product;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm_8,
        vertical: AppSizes.paddingMd_16,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.paddingMd_16),
        boxShadow: [BoxShadow(color: AppColorsLight.white[60]!, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.borderRadiusXxl_24,
            backgroundColor: AppColorsLight.white[60],
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: product.imgCover,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                placeholder: (context, url) => const Icon(
                  Icons.person,
                  size: AppSizes.icon_36,
                  color: AppColorsLight.grey,
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: AppColorsLight.red),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceBetweenItems_8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: AppColorsLight.grey,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      '${LocaleKeys.times_prefix.tr()}${product.quantity}',
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_8),
                Text(
                  '${LocaleKeys.currency.tr()} ${product.priceAfterDiscount}',
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: AppColorsLight.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
