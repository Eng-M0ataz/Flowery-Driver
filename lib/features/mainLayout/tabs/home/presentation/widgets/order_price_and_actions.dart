import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/accept_order_button.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/custom_home_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPriceAndActions extends StatelessWidget {
  const OrderPriceAndActions({super.key, required this.order});

  final PendingOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${LocaleKeys.currency.tr()} ${order.totalPrice}',
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomHomeElevatedButton(
          title: LocaleKeys.reject.tr(),
          onPressed: () {
            context.read<HomeViewModel>().doIntend(RejectOrderEvent(order.id!));
          },
        ),
        AcceptOrderButton(order: order),
      ],
    );
  }
}
