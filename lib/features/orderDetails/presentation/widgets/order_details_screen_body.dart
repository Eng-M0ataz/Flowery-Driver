import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_card_header.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_orders_listview.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_step_widget.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_transactions_info.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_detials_user_store_info_card.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_status_info.dart';
import 'package:flutter/material.dart';
import 'package:step_progress/step_progress.dart';

class OrderDetailsScreenBody extends StatelessWidget {
  const OrderDetailsScreenBody({
    super.key,
    required this.orderDetailsModel,
    required this.stepProgressController,
  });
  final OrderDetailsModel orderDetailsModel;
  final StepProgressController stepProgressController;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OrderDetailsStepWidget(controller: stepProgressController),
        OrderStatusInfo(
          orderDetailsModel: orderDetailsModel,
          stepProgressController: stepProgressController,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
            vertical: AppSizes.paddingMd_16,
          ),
          child: Text(
            LocaleKeys.pickup_address.tr(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        OrderDetailUserAndStoreInfoCard(
          phoneNumber: orderDetailsModel.storeInfo.phone,
          imageUrl: orderDetailsModel.storeInfo.imageUrl,
          name: orderDetailsModel.storeInfo.name,
          location: orderDetailsModel.storeInfo.address,
        ),
        CardHeader(text: LocaleKeys.user_address.tr()),
        OrderDetailUserAndStoreInfoCard(
          phoneNumber: orderDetailsModel.userInfo.phone,
          imageUrl: orderDetailsModel.userInfo.photoUrl,
          name: orderDetailsModel.userInfo.name,
          location: orderDetailsModel.userInfo.address,
        ),
        CardHeader(text: LocaleKeys.order_details.tr()),
        OrderItemsListView(productList: orderDetailsModel.productList),
        const SizedBox(height: AppSizes.spaceBetweenItems_24),
        OrderDetailsTransactioninfo(
          name: LocaleKeys.total.tr(),
          data: '${LocaleKeys.currency.tr()} ${orderDetailsModel.totalPrice}',
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_24),
        OrderDetailsTransactioninfo(
          name: LocaleKeys.payment_method.tr(),
          data: orderDetailsModel.paymentType,
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_24),
      ],
    );
  }
}
