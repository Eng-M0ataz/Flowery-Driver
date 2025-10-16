import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:step_progress/step_progress.dart';

class OrderDetailsStepWidget extends StatelessWidget {
  const OrderDetailsStepWidget({super.key, required this.controller});
  final StepProgressController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: StepProgress(
        totalSteps: 5,
        visibilityOptions: StepProgressVisibilityOptions.lineOnly,
        controller: controller,
        highlightOptions:
            StepProgressHighlightOptions.highlightCompletedNodesAndLines,
        theme: StepProgressThemeData(
          stepLineSpacing: 6,
          defaultForegroundColor: AppColorsLight.white[70]!,
          activeForegroundColor: Theme.of(context).colorScheme.secondary,
          stepLineStyle: const StepLineStyle(
            lineThickness: 4,
            borderRadius: Radius.circular(AppSizes.borderRadiusFull),
          ),
        ),
      ),
    );
  }
}
