import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/order_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

class OrderOrderDetailsScreen extends StatelessWidget {
  const OrderOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)?.settings.arguments as AllOrdersEntity;

    return BlocProvider(
      create: (context) =>
          getIt.get<OrdersViewModel>()
            ..doIntend(GetProductEvent(order.order.orderItems[0].product.id)),
      child: OrderDetailsWidget(order: order),
    );
  }
}
