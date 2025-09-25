import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_event.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/build_pin_code.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/build_title_with_subtitle.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/main_timer.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/resend_text.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/resend_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodeWidget extends StatelessWidget {
  const VerificationCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.spaceBetweenItems_16),
        CustomAppBar(title: LocaleKeys.password.tr()),
        const SizedBox(height: AppSizes.spaceBetweenItems_40),
        BuildTitleWithSubtitle(
          title: LocaleKeys.resetPassword.tr(),
          subTitle: LocaleKeys.enterCodeInstruction.tr(),
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_32),
        Form(
          key: viewModel.verifyCodeKey,
          child: Column(
            children: [
              BuildPinCode(
                controller: viewModel.codeController,
                onCompleted: (String value) {
                  viewModel.doIntent(VerifyCodeEvent());
                },
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_16),
              const MainTimer(),
              const SizedBox(height: AppSizes.spaceBetweenItems_8),
              BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.didNotReceiveCode.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          TextButton(
                            onPressed: state.isResendAvailable
                                ? () {
                                    viewModel.doIntent(ResendCodeEvent());
                                  }
                                : null,
                            child: ResendText(
                              isResendAvailable: state.isResendAvailable,
                            ),
                          ),
                        ],
                      ),
                      !state.isResendAvailable
                          ? ResendTimer(
                              onEnd: () {
                                viewModel.doIntent(ResendTimerFinishedEvent());
                              },
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
