import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/address_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({super.key, required this.status, required this.orderNumber, required this.storeAddress, required this.userAddress, required this.storeName, required this.userName, required this.storeImage, required this.userImage, this.onTap});
  final String status;
  final String orderNumber;
  final String storeAddress;
  final String userAddress;
  final String storeName;
  final String userName;
  final String storeImage;
  final String userImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.paddingMd_16),
        margin:  const EdgeInsets.symmetric(vertical: AppSizes.spaceBetweenItems_8, horizontal: AppSizes.spaceBetweenItems_2),
        decoration: BoxDecoration(
          color: AppColorsLight.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
          boxShadow: [
            BoxShadow(
              color: AppColorsLight.grey.withValues(alpha: 0.4),
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          spacing: AppSizes.spaceBetweenItems_16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.flowerOrder,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            OrderStateWidget(orderNumber: orderNumber, state: status),
            Text(
              LocaleKeys.pickupAddress,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColorsLight.grey,
              ),
            ),
            AddressCard(name: storeName,imagePath: storeImage,address: storeAddress,),
            Text(
              LocaleKeys.userAddress,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColorsLight.grey,
              ),
            ),
            AddressCard(name: userName,imagePath: userImage, address: userAddress,),
          ],
        ),
      ),
    );
  }
}
