import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/address_info_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';

class OrderAddressSection extends StatelessWidget {
  const OrderAddressSection({super.key, required this.order});

  final PendingOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddressInfoCard(
          imageUrl: order.store!.image!,
          name: order.store!.name!,
          location: order.store!.address!,
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_16),
        Text(
          LocaleKeys.user_address.tr(),
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_8),
        AddressInfoCard(
          imageUrl: order.user!.photo!,
          name: order.user!.name!,
          location:
          '${order.shippingAddress?.street}, ${order.shippingAddress?.city}',
        ),
      ],
    );
  }
}
