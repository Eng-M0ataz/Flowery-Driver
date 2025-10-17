import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/functions/snack_bar.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/flower_order_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/order_shimmer_widget.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/error_section.dart';

class OrdersSection extends StatelessWidget {

  const OrdersSection({
    super.key,
    required this.homeViewModel,
    required this.scrollController,
  });
  final HomeViewModel homeViewModel;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, HomeState>(
      listenWhen: (previous, current) =>
      previous.orderRejected != current.orderRejected,
      listener: (context, state) {
        if (state.orderRejected) {
          showSnackBar(
            context: context,
            title: LocaleKeys.reject.tr(),
            message: LocaleKeys.order_rejected.tr(),
            color: Theme.of(context).colorScheme.primary,
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading && state.orders.isEmpty) {
          return const Expanded(child: Center(child: OrderShimmerWidget()));
        }

        if (state.driverDataFailure != null) {
          return ErrorSection(
            message: state.driverDataFailure!.errorMessage,
            onRetry: () => homeViewModel.doIntend(GetDriverDataEvent()),
          );
        }

        if (state.failure != null) {
          return ErrorSection(
            message: state.failure!.errorMessage,
            onRetry: () => homeViewModel.doIntend(LoadInitialOrdersEvent()),
          );
        }

        if (state.orders.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(LocaleKeys.no_pending_orders.tr()),
            ),
          );
        }

        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              homeViewModel.doIntend(RefreshOrdersEvent());
            },
            child: ListView.builder(
              controller: scrollController,
              itemCount: state.orders.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.orders.length) {
                  return FlowerOrderCard(order: state.orders[index]);
                } else if (!state.hasMore) {
                  return Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                    child: Center(
                      child: Text(LocaleKeys.no_pending_orders.tr()),
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(AppSizes.paddingSm_8),
                  child: Center(child: OrderShimmerWidget()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
