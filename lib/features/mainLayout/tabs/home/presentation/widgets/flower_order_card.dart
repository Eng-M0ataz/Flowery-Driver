import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
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
            imageUrl: order.user!.photo!,

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
              BlocConsumer<HomeViewModel, HomeState>(
                listener: (context, state) {
                  if (state.startOrderEntity != null &&
                      state.startOrderEntity!.id == order.id) {
                    final allProducts = order.orderItems!
                        .expand((orderItem) => orderItem.productList ?? [])
                        .toList();

                    final OrderDetailsModel args = OrderDetailsModel(
                      storeInfo: StoreInfo(
                        name: order.store!.name!,
                        address: order.store!.address!,
                        imageUrl: order.store!.image!,
                        phone: order.store!.phone!,
                      ),
                      userInfo: UserInfo(
                        name: order.user!.name!,
                        photoUrl: order.user!.photo!,
                        phone: order.user!.phone!,
                        address:
                            '${order.shippingAddress!.street!}, ${order.shippingAddress!.city!}',
                      ),
                      totalPrice: order.totalPrice!,
                      status: AppConstants.inProgress,
                      orderId: order.id!,
                      orderNumber: order.orderNumber!,
                      paymentType: order.paymentType!,
                      updatedAt: state.startOrderEntity?.updatedAt ?? '',

                      productList: allProducts
                          .map(
                            (product) => ProductInfo(
                              title: product.title!,
                              imgCover: product.imgCover!,
                              priceAfterDiscount: product.priceAfterDiscount!,
                              quantity: product.quantity!,
                            ),
                          )
                          .toList(),
                    );

                    context.read<HomeViewModel>().doIntend(
                      NavigateToOrderDetailsUiEvent(args),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: AppSizes.padding_100,
                    height: AppSizes.padding_36,
                    child: CustomElevatedButton(
                      isLoading:
                          state.loadingProducts?[order.id] ??
                          false,
                      widget: Text(
                        LocaleKeys.accept.tr(),
                        style: theme.textTheme.displayLarge!.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      onPressed: () async {
                        await context.read<HomeViewModel>().doIntend(
                          StartOrderEvent(orderId: order.id!),
                        );
                      },

                      textColor: theme.colorScheme.onPrimary,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
