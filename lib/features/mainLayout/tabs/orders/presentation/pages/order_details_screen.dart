  import 'package:easy_localization/easy_localization.dart';
  import 'package:flowery_tracking/core/di/di.dart';
  import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
  import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/all_orders_entity.dart';
  import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
  import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';
  import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_widget.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

  class OrderDetailsScreen extends StatelessWidget {
    const OrderDetailsScreen({super.key});

    @override
    Widget build(BuildContext context) {
      final order = ModalRoute.of(context)?.settings.arguments;

      if (order == null || order is! AllOrdersEntity) {
        return  Scaffold(
          body: Center(child: Text(LocaleKeys.noOrders.tr())),
        );
      }
      return BlocProvider(
        create: (context) =>
        getIt.get<OrdersViewModel>()..doIntend(GetProductEvent(order.order!.orderItems![0].product!.Id!)),
        child: OrderDetailsWidget(order: order),
      );




    }
  }
