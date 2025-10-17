import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/enum/location_return_types.dart';
import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/functions/date_formater.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/services/location_service.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_events.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_state.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_view_model.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_nav_bar.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress/step_progress.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderDetailsModel});
  final OrderDetailsModel orderDetailsModel;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

late final StepProgressController _stepProgressController;
late final OrderDetailsViewModel _orderDetailsViewModel;

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    _orderDetailsViewModel = getIt<OrderDetailsViewModel>();
    _orderDetailsViewModel.doIntent(
      event: UpdateOrderStatusOnServerEvent(
        path:
            '${widget.orderDetailsModel.orderId}${ApiConstants.orderStatusPath}${OrderStatus.accepted.name}',
        updateOrderStatusWithServerModel: UpdateOrderStatusWithServerModel(
          status: OrderStatus.accepted.name,
          statusUpdatedDate: formatDate(
            date: DateTime.now(),
            format: AppConstants.orderDetailsTimeAndDateFormat,
          ),
        ),
      ),
    );
    _orderDetailsViewModel.doIntent(
      event: CheckLocationPermissionAndStreamDriverLocation(
        path:
            '${widget.orderDetailsModel.orderId}${ApiConstants.driverLocationPath}',
      ),
    );
    _stepProgressController = StepProgressController(
      totalSteps: 5,
      initialStep: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _stepProgressController.dispose();
    _orderDetailsViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderDetailsViewModel,
      child: Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.order_details_title.tr()),
        bottomNavigationBar: OrderDetailsBottomNavigationBar(
          stepProgressController: _stepProgressController,
          orderDetailsViewModel: _orderDetailsViewModel,
          orderDetailsModel: widget.orderDetailsModel,
        ),
        body: BlocListener<OrderDetailsViewModel, OrderDetailsState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage &&
              current.errorMessage != null,
          listener: (context, state) {
            if (state.errorMessage ==
                    LocationReturnTypes.locationPermissionDeniedForever.name ||
                state.errorMessage ==
                    LocationReturnTypes.locationPermissionDenied.name) {
              DialogueUtils.showMessage(
                context: context,
                message: LocaleKeys.enable_location_permission_message.tr(),
                posActionName: LocaleKeys.open_setting.tr(),
                posAction: () async {
                  await LocationService.openAppSettings();
                },
                ngeAction: () {
                  context.pop();
                },
              );
            }
            if (state.errorMessage ==
                LocationReturnTypes.locationServiceDisabled.name) {
              DialogueUtils.showMessage(
                context: context,
                message: LocaleKeys.enable_location_service_message.tr(),
                posActionName: LocaleKeys.open_location_setting.tr().tr(),
                posAction: () async {
                  final bool isOpened =
                      await LocationService.openLocationSettings();
                  if (isOpened) {
                    await _orderDetailsViewModel.doIntent(
                      event: CheckLocationPermissionAndStreamDriverLocation(
                        path:
                            '${widget.orderDetailsModel.orderId}${ApiConstants.driverLocationPath}',
                      ),
                    );
                  }
                },
              );
            }
          },
          child: OrderDetailsScreenBody(
            orderDetailsModel: widget.orderDetailsModel,
            stepProgressController: _stepProgressController,
          ),
        ),
      ),
    );
  }
}
