import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/order_header_section.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/order_address_section.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/order_price_and_actions.dart';
import 'package:flutter/material.dart';

class FlowerOrderCard extends StatelessWidget {
  const FlowerOrderCard({super.key, required this.order});

  final PendingOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(AppSizes.paddingMd_16),
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.paddingMd_16),
        boxShadow: [
          BoxShadow(
            color: AppColorsLight.white[60] ?? Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OrderHeaderSection(),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          OrderAddressSection(order: order),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          OrderPriceAndActions(order: order),
        ],
      ),
    );
  }
}
