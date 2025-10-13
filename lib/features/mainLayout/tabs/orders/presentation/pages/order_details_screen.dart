import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/address_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_text_widget.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_state_widget.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/payment_data.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)?.settings.arguments;

    if (order == null || order is! AllOrdersEntity) {
      return const Scaffold(
        body: Center(child: Text('No order details available')),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.orderDetails.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.spaceBetweenItems_24,
                  bottom: AppSizes.spaceBetweenItems_6
                ),
                child: OrderStateWidget(orderNumber: order.order!.orderNumber!, state: order.order!.state!),
              ),
              OrderDetailsTextWidget(title: LocaleKeys.pickupAddress.tr()),
              AddressCard(name: order.store!.name!, imagePath: order.store!.image!, address: order.store!.address!),
              OrderDetailsTextWidget(title: LocaleKeys.userAddress.tr()),
              AddressCard(name: order.order!.user!.firstName!, imagePath: order.order!.user!.photo!, address: order.order!.user!.email!),
              OrderDetailsTextWidget(title: LocaleKeys.orderDetails.tr()),
              const SizedBox(height: AppSizes.spaceBetweenItems_12,),
              PaymentData(title: LocaleKeys.total.tr(), paymentMethod: '${LocaleKeys.egp.tr()} ${order.order!.totalPrice!}'),
              PaymentData(title: LocaleKeys.paymentMethod.tr(), paymentMethod: order.order!.paymentType!),

            ],
          ),
        ),
      ),
    );
  }
}
