import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/orders_status_bar.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.myOrders.tr(), onTap: () {}),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSizes.spaceBetweenItems_16,
          children: [
            const OrdersStatusBar(),
            Text(
              LocaleKeys.recentOrders.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const OrderDetailsCard()
          ],
        ),
      ),
    );
  }
}
