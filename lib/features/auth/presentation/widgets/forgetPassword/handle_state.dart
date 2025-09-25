import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flutter/material.dart';

void handleState<T>({
  required BuildContext context,
  required T status,
  required String successMessage,
  required String errorMessage,
  VoidCallback? onSuccess,
  VoidCallback? onError,
}) {
  if (status == ForgetPasswordStatus.error) {
    DialogueUtils.showMessage(
      context: context,
      message: errorMessage,
      title: LocaleKeys.error.tr(),
      posActionName: LocaleKeys.ok.tr(),
      posAction: onError,
    );
  } else if (status == ForgetPasswordStatus.success) {
    DialogueUtils.showMessage(
      context: context,
      message: successMessage,
      title: LocaleKeys.success.tr(),
      posActionName: LocaleKeys.ok.tr(),
      posAction: onSuccess,
    );
  }
}
