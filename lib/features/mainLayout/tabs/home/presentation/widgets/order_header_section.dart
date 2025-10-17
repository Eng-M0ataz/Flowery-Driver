import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OrderHeaderSection extends StatelessWidget {
  const OrderHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.flower_order.tr(),
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LocaleKeys.pickup_address.tr(),
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
