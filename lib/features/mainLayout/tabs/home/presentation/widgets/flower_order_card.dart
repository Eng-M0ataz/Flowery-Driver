import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_args.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/address_info_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/custom_home_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlowerOrderCard extends StatelessWidget {
  const FlowerOrderCard({super.key, required this.order});

  final PendingOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
          const SizedBox(height: AppSizes.spaceBetweenItems_16),

          Text(
            LocaleKeys.flower_order.tr(),
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppSizes.spaceBetweenItems_16),

          Text(
            LocaleKeys.pickup_address.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColorsLight.grey,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
          AddressInfoCard(
            imageUrl: order.store!.image!,
            name: order.store!.name!,
            location: order.store!.address!,
          ),

          const SizedBox(height: AppSizes.spaceBetweenItems_16),

          Text(
            LocaleKeys.user_address.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColorsLight.grey,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
          AddressInfoCard(
            imageUrl: '${ApiConstants.imageBaseUrl}${order.user!.photo}',

            name: order.user!.name!,
            location:
                '${order.shippingAddress?.street}, ${order.shippingAddress?.city}',
          ),

          const SizedBox(height: AppSizes.spaceBetweenItems_16),

          Row(
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
                  context.read<HomeViewModel>().doIntend(
                    RejectOrderEvent(order.id!),
                  );
                },
              ),
              CustomHomeElevatedButton(
                title: LocaleKeys.accept.tr(),
                onPressed: () {
                  final OrderDetailsArgs args = OrderDetailsArgs(
                    storeName:
                        order.store?.name ?? LocaleKeys.unknown_store.tr(),
                    storeAddress: order.store!.address!,
                    storeImage: order.store!.image!,
                    userName: order.user!.name!,
                    userPhoto:
                        '${ApiConstants.imageBaseUrl}${order.user!.photo}',

                    userAddress:
                        '${order.shippingAddress?.street }, ${order.shippingAddress?.city  }',

                    totalPrice: order.totalPrice!,
                  );
                  context.read<HomeViewModel>().doIntend(
                    NavigateToOrderDetailsUiEvent(args),
                  );
                },
                backgroundColor: theme.colorScheme.primary,
                textColor: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
