import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/functions/custom_password_text_form_field.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_event.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/build_title_with_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSizes.spaceBetweenItems_40),
          BuildTitleWithSubtitle(
            title: LocaleKeys.resetPassword.tr(),
            subTitle: LocaleKeys.passwordValidation.tr(),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_32),
          Form(
            key: viewModel.resetPasswordKey,
            child: Column(
              children: [
                CustomPasswordTextFormField(
                  controller: viewModel.newPasswordController,
                  hint: LocaleKeys.enterPassword.tr(),
                  label: LocaleKeys.newPassword.tr(),
                  validator:Validations.validatePassword ,
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_24),
                CustomPasswordTextFormField(
                  controller: viewModel.confirmPasswordController,
                  validator: (val) => Validations.validateConfirmPassword(
                    val,
                    viewModel.newPasswordController.text,
                  ),
                  hint: LocaleKeys.confirmPassword.tr(),
                  label: LocaleKeys.confirmPassword.tr(),
                ),

                const SizedBox(height: AppSizes.spaceBetweenItems_48),
                BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () => viewModel.doIntent(ResetPasswordEvent()),
                      isLoading: state.status == ForgetPasswordStatus.loading,
                      widget: Text(LocaleKeys.confirm.tr()),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
        ],
      ),
    );
  }
}
