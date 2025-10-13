import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_states.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/orders_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  late final OrdersViewModel ordersViewModel;

  @override
  void initState() {
    super.initState();
    ordersViewModel = context.read<OrdersViewModel>();
    ordersViewModel.doIntend(GetDriverOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersViewModel, OrdersStates>(
      builder: (context, state) {
        if(state.isLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else if(state.failure != null){
          return Center(child: Text(state.failure!.errorMessage));
        }
        return Scaffold(
          appBar: CustomAppBar(title: LocaleKeys.myOrders.tr(), onTap: () {}),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd_16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSizes.spaceBetweenItems_16,
              children: [
                OrdersStatusBar(
                  cancelled: ordersViewModel.cancelled,
                  completed: ordersViewModel.completed,
                ),
                Text(
                  LocaleKeys.recentOrders.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                if (state.driverOrdersResponseEntity != null)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return OrderDetailsCard(
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.orderDetailsRoute,
                              arguments: state.driverOrdersResponseEntity!.orders![index],
                            );
                          },
                          orderNumber:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .order!
                                  .orderNumber ??
                              '',
                          status:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .order!
                                  .state ??
                              '',
                          storeAddress:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .store!
                                  .address ??
                              '',
                          storeImage:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .store!
                                  .image ??
                              '',
                          storeName:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .store!
                                  .name ??
                              '',
                          userAddress:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .order!
                                  .user!
                                  .email ??
                              '',
                          userImage:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .order!
                                  .user!
                                  .photo ??
                              '',
                          userName:
                              state
                                  .driverOrdersResponseEntity!
                                  .orders![index]
                                  .order!
                                  .user!
                                  .firstName ??
                              '',
                        );
                      },
                      itemCount:
                          state.driverOrdersResponseEntity!.orders!.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
