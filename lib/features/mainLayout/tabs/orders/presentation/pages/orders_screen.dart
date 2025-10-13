import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/widgets/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<OrdersViewModel>()..doIntend(GetDriverOrdersEvent()),
      child: const Orders(),
    );
  }
}
