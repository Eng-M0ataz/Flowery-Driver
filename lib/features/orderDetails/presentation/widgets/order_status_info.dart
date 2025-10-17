import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/functions/get_status_from_step.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_state.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress/step_progress.dart';

class OrderStatusInfo extends StatelessWidget {
  const OrderStatusInfo({
    super.key,
    required this.orderDetailsModel,
    required this.stepProgressController,
  });
  final OrderDetailsModel orderDetailsModel;
  final StepProgressController stepProgressController;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        color: AppColorsLight.lightPink,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_10),
      ),
      child: BlocBuilder<OrderDetailsViewModel, OrderDetailsState>(
        buildWhen: (previous, current) =>
            previous.orderStatus != current.orderStatus,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.status_with_value.tr(
                  namedArgs: {
                    'value': getStatusFromStep(
                      stepProgressController.currentStep,
                    ).displayName,
                  },
                ),
                style: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                LocaleKeys.order_id_with_value.tr(
                  namedArgs: {'value': orderDetailsModel.orderNumber},
                ),
                style: theme.textTheme.labelLarge!,
              ),
              Text(
                DateFormat(
                  AppConstants.orderDetailsTimeAndDateFormat,
                ).format(DateTime.now()),
                style: theme.textTheme.labelLarge!.copyWith(
                  color: AppColorsLight.grey,
                  fontSize: AppSizes.smFont_14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
