import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_states.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/address_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_text_widget.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_state_widget.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/payment_data.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsWidget extends StatefulWidget {
  const OrderDetailsWidget({super.key, required this.order});

  final AllOrdersEntity order;

  @override
  State<OrderDetailsWidget> createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  late final OrdersViewModel ordersViewModel;

  @override
  void initState() {
    super.initState();
    ordersViewModel = context.read<OrdersViewModel>();
    ordersViewModel.doIntend(
      GetProductEvent(widget.order.order.orderItems[0].product.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.orderDetails.tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
          vertical: AppSizes.paddingSm_8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: AppSizes.spaceBetweenItems_24,
                bottom: AppSizes.spaceBetweenItems_6,
              ),
              child: OrderStateWidget(
                orderNumber: widget.order.order.orderNumber,
                state: widget.order.order.state,
              ),
            ),
            OrderDetailsTextWidget(title: LocaleKeys.pickupAddress.tr()),
            AddressCard(
              name: widget.order.store.name,
              imagePath: widget.order.store.image,
              address: widget.order.store.address,
            ),
            OrderDetailsTextWidget(title: LocaleKeys.userAddress.tr()),
            AddressCard(
              name: widget.order.order.user.firstName,
              imagePath: AppConstants.imagePath,
              address: widget.order.order.user.email,
            ),
            OrderDetailsTextWidget(title: LocaleKeys.orderDetails.tr()),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: AppSizes.spaceBetweenItems_12);
                },
                itemBuilder: (context, index) {
                  return BlocBuilder<OrdersViewModel, OrdersStates>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if (state.failure != null) {
                        return Center(child: Text(state.failure!.errorMessage));
                      }
                      return ProductCard(
                        imagePath: state.productDataEntity!.product!.imgCover,
                        title: state.productDataEntity!.product!.title,
                        price: widget.order.order.orderItems[index].price,
                        quantity: widget.order.order.orderItems[index].quantity,
                      );
                    },
                  );
                },
                itemCount: widget.order.order.orderItems.length,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_12),
            PaymentData(
              title: LocaleKeys.total.tr(),
              paymentMethod:
                  '${LocaleKeys.egp.tr()} ${widget.order.order.totalPrice}',
            ),
            PaymentData(
              title: LocaleKeys.paymentMethod.tr(),
              paymentMethod: widget.order.order.paymentType,
            ),
          ],
        ),
      ),
    );
  }
}
