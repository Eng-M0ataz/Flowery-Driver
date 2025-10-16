import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_event.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/build_email_field.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/build_title_with_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSizes.spaceBetweenItems_40),
          BuildTitleWithSubtitle(
            title: LocaleKeys.forgetPassword.tr(),
            subTitle: LocaleKeys.enterEmailInstruction.tr(),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_32),
          Form(
            key: viewModel.forgetPasswordKey,
            child: Column(
              children: [
                BuildEmailField(controller: viewModel.emailController),
                const SizedBox(height: AppSizes.spaceBetweenItems_48),
                BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () =>
                          viewModel.doIntent(SendForgetRequestEvent()),
                      isLoading: state.status == ForgetPasswordStatus.loading,
                      widget: Text(LocaleKeys.confirm.tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
