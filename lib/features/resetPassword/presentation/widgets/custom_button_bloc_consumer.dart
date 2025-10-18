import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_event.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_stats.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuustomButtonBlocConsumer extends StatelessWidget {
  const CuustomButtonBlocConsumer({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.resetPasswordViewModel,
    required this.formKey,
  });
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final ResetPasswordViewModel resetPasswordViewModel;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordViewModel, ResetPasswordState>(
      listenWhen: (previous, current) => previous.failure != current.failure,
      listener: (context, state) {
        if (state.failure != null) {
          DialogueUtils.showMessage(
            context: context,
            title: LocaleKeys.error.tr(),
            message: state.failure!.errorMessage,
            posActionName: LocaleKeys.ok.tr(),
          );
          if (state.resetPasswordSuccess) {
            DialogueUtils.showMessage(
              context: context,
              title: LocaleKeys.success.tr(),
              message: LocaleKeys.passwordUpdated.tr(),
              posActionName: LocaleKeys.ok.tr(),
            );
          }
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state.isLoading,
          widget: Text(LocaleKeys.update.tr()),
          onPressed: () {
            final resetPasswordRequestModel = ResetPasswordRequestModel(
              newPassword: newPasswordController.text,
              password: currentPasswordController.text,
            );
            if (formKey.currentState!.validate()) {
              resetPasswordViewModel.doIntent(
                event: ResetPasswordEvent(),
                resetPasswordRequestModel: resetPasswordRequestModel,
              );
            }
          },
        );
      },
    );
  }
}
