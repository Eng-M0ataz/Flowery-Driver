import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class BuildPinCode extends StatelessWidget {
  const BuildPinCode({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  final TextEditingController controller;

  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: AppSizes.pinCodeLength_6,
      controller: controller,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: AppSizes.pinCodeWidth_68,
        height: AppSizes.pinCodeHeight_74,
        textStyle: Theme.of(context).textTheme.titleLarge,
        decoration: BoxDecoration(
          color: AppColorsLight.black[10],
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
        ),
      ),
      onCompleted: onCompleted,
      validator: Validations.pinCodeValidator,
      errorPinTheme: PinTheme(
        width: AppSizes.pinCodeWidth_68,
        height: AppSizes.pinCodeHeight_74,
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
          border: Border.all(
            color: Theme.of(context).colorScheme.error,
            width: AppSizes.pinCodeBorderWidth_2,
          ),
        ),
      ),
    );
  }
}
