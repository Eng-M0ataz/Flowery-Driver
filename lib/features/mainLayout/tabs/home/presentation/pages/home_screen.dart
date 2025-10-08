import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Di/di.dart';
import 'package:flowery_tracking/core/functions/snack_bar.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/flower_order_card.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/widgets/order_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _homeViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeViewModel = getIt<HomeViewModel>();
    _homeViewModel.doIntend(LoadInitialOrdersEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 500) {
        _homeViewModel.doIntend(LoadNextOrdersEvent());
      }
    });

    _homeViewModel.uiEvents.listen((event) {
      if (event is NavigateToOrderDetailsUiEvent) {
        // after merge i will change this to use app routes
        context.pushNamed('orderDetails', arguments: event.args);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _homeViewModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewModel>.value(
      value: _homeViewModel,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.spaceBetweenItems_32),
              Padding(
                padding: const EdgeInsets.only(left: AppSizes.paddingMd_16),
                child: SvgPicture.asset(
                  Assets.assetsImagesFloweryRider,
                  width: AppSizes.imageLogoWidth_113,
                  height: AppSizes.imageLogoHeight_25,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_16),

              BlocConsumer<HomeViewModel, HomeState>(
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
                  if (state.isLoading && state.orders.isEmpty == true) {
                    return const Expanded(
                      child: Center(child: OrderShimmerWidget()),
                    );
                  } else if (state.failure != null) {
                    return Center(
                      child: Column(
                        children: [
                          Builder(
                            builder: (context) {
                              return Text(state.failure!.errorMessage);
                            },
                          ),

                          const SizedBox(height: AppSizes.spaceBetweenItems_8),
                          ElevatedButton(
                            onPressed: () {
                              _homeViewModel.doIntend(LoadInitialOrdersEvent());
                            },
                            child: Text(LocaleKeys.retry.tr()),
                          ),
                        ],
                      ),
                    );
                  } else if (state.orders.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(LocaleKeys.no_pending_orders.tr()),
                      ),
                    );
                  }

                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _homeViewModel.doIntend(RefreshOrdersEvent());
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            state.orders.length + (state.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < state.orders.length) {
                            return FlowerOrderCard(order: state.orders[index],);
                          } else {
                            if (!state.hasMore) {
                              return Padding(
                                padding: const EdgeInsets.all(
                                  AppSizes.paddingMd_16,
                                ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.no_pending_orders.tr(),
                                  ),
                                ),
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.all(AppSizes.paddingSm_8),
                              child: Center(child: OrderShimmerWidget()),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
