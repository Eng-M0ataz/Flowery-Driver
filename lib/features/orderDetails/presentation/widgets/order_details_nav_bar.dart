import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/functions/date_formater.dart';
import 'package:flowery_tracking/core/functions/get_status_from_step.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_events.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_state.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress/step_progress.dart';

class OrderDetailsBottomNavigationBar extends StatelessWidget {
  const OrderDetailsBottomNavigationBar({
    super.key,
    required this.stepProgressController,
    required this.orderDetailsViewModel,
    required this.orderDetailsModel,
  });
  final StepProgressController stepProgressController;
  final OrderDetailsViewModel orderDetailsViewModel;
  final OrderDetailsModel orderDetailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
      builder: (context, state) {
        return Container(
          height: 96,
          color: Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
          ),
          child: CustomElevatedButton(
            onPressed: state.orderStatus != OrderStatus.delivered
                ? () async {
                    final step = stepProgressController.currentStep + 1;
                    orderDetailsViewModel.doIntent(
                      event: HandleOrderStatusFlowEvent(
                        path:
                            '${orderDetailsModel.orderId}${ApiConstants.orderStatusPath}${getStatusFromStep(step).name}',
                        orderId: orderDetailsModel.orderId,
                        deletePath: orderDetailsModel.orderId,
                        updateOrderStatusModel:
                            UpdateOrderStatusWithServerModel(
                              status: getStatusFromStep(step).name,
                              statusUpdatedDate: formatDate(
                                date: DateTime.now(),
                                format:
                                    AppConstants.orderDetailsTimeAndDateFormat,
                              ),
                            ),
                        updateOrderStatusWithApiModel:
                            const UpdateOrderStatusWithApiModel(
                              state: AppConstants.orderCompleted,
                            ),
                      ),
                    );
                    stepProgressController.nextStep();
                  }
                : null,
            isLoading: state.orderStatus == null ? false : state.isLoading!,
            widget: Text(
              getStatusFromStep(
                stepProgressController.currentStep,
              ).buttonDisplayName,
            ),
          ),
        );
      },
    );
  }
}
