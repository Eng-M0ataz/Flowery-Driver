import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/status_card.dart';
import 'package:flutter/material.dart';

class OrdersStatusBar extends StatelessWidget {
  const OrdersStatusBar({super.key, required this.completed, required this.cancelled});
  final int completed;
  final int cancelled;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.spaceBetweenItems_32,
      children: [
          Expanded(child: StatusCard(ordersNumbers: cancelled, status: LocaleKeys.cancelled.tr(), iconPath: Assets.assetsImagesCancel)),
          Expanded(child: StatusCard(ordersNumbers: completed, status: LocaleKeys.completed.tr(), iconPath: Assets.assetsImagesCheckCircle)),
      ],
    );
  }
}
