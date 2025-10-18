import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/functions/initialize_order_data.dart';
import 'package:flowery_tracking/core/functions/snack_bar.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/build_order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptOrderButton extends StatelessWidget {
  const AcceptOrderButton({super.key, required this.order});

  final PendingOrderEntity order;

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();
    final theme = Theme.of(context);

    return BlocConsumer<HomeViewModel, HomeState>(
      listenWhen: (previous, current) {
        final isStartOrderFailed =
            previous.startOrderFailure != current.startOrderFailure &&
            current.startOrderFailure != null;
        final isCreateOrderFailed =
            previous.createOrderFailure != current.createOrderFailure &&
            current.createOrderFailure != null;
        return isStartOrderFailed || isCreateOrderFailed;
      },
      listener: (context, state) {
        if (state.startOrderFailure != null) {
          showSnackBar(
            context: context,
            title: LocaleKeys.error.tr(),
            message: state.startOrderFailure!.errorMessage,
          );
        } else if (state.createOrderFailure != null) {
          showSnackBar(
            context: context,
            title: LocaleKeys.error.tr(),
            message: state.createOrderFailure!.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: AppSizes.padding_100,
          height: AppSizes.padding_36,
          child: CustomElevatedButton(
            isLoading: state.loadingProducts?[order.id] ?? false,
            widget: Text(
              LocaleKeys.accept.tr(),
              style: theme.textTheme.displayLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
            onPressed: () async {
              await homeViewModel.doIntend(StartOrderEvent(orderId: order.id!));

              if (homeViewModel.state.startOrderFailure != null) return;

              final orderDetailsRequestModel = await initializeOrderData(
                context: context,
                state: homeViewModel.state,
                order: order,
              );

              await homeViewModel.doIntend(
                CreateOrderEvent(
                  orderDetailsRequestModel: orderDetailsRequestModel,
                  path: order.id!,
                ),
              );

              if (homeViewModel.state.createOrderFailure != null) return;

              final finalState = homeViewModel.state;
              if (finalState.startOrderEntity != null &&
                  finalState.startOrderEntity!.id == order.id) {
                final args = buildOrderDetailsModel(
                  order: order,
                  state: finalState,
                );
                context.pushReplacementNamed(
                  AppRoutes.orderDetailsRoute,
                  arguments: args,
                );
              }
            },
          ),
        );
      },
    );
  }
}
