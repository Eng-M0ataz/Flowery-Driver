import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Di/di.dart';
import 'package:flowery_tracking/core/Widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/forget_password_widget.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/handle_state.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/reset_password_widget.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/forgetPassword/verification_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordViewModel viewModel;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<ForgetPasswordViewModel>();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          handleState<ForgetPasswordStatus>(
            context: context,
            status: state.status,
            successMessage: getSuccessMessage(state),
            errorMessage: state.failure?.errorMessage.isNotEmpty == true
                ? state.failure!.errorMessage
                : LocaleKeys.unexpectedError.tr(),
            onSuccess: () {
              handleNavigation(
                context: context,
                state: state,
                pageController: pageController,
              );
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: LocaleKeys.password.tr()),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd_16,
              ),
              child: Center(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ForgetPasswordWidget(),
                    VerificationCodeWidget(),
                    ResetPasswordWidget(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void handleNavigation({
  required BuildContext context,
  required ForgetPasswordState state,
  required PageController pageController,
}) {
  switch (state.step) {
    case ForgetPasswordStep.verify:
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      break;
    case ForgetPasswordStep.reset:
      if (state.resetResponse != null) {
        context.pop();
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      break;
    case ForgetPasswordStep.resend:
      break;
    case ForgetPasswordStep.forget:
      break;
  }
}

String getSuccessMessage(ForgetPasswordState state) {
  switch (state.step) {
    case ForgetPasswordStep.verify:
    case ForgetPasswordStep.resend:
      return state.forgetResponse?.info ?? LocaleKeys.operationCompleted.tr();
    case ForgetPasswordStep.reset:
      if(state.resetResponse != null){
        return LocaleKeys.passwordResetSuccessfully.tr();
      } else {
        return  LocaleKeys.codeVerifiedSuccessfully.tr();
      }
    default:
      return LocaleKeys.operationCompleted.tr();
  }
}
