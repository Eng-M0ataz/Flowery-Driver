import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/app_text_form_field.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/widgets/custom_button.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_view_model.dart';
import 'package:flowery_tracking/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final SignInViewModel _viewModel;

  @override
  void initState() {
    _viewModel = getIt<SignInViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: LocaleKeys.login.tr(),),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd_16,
              ),
              child: Form(
                key: _viewModel.formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: AppSizes.spaceBetweenItems_24),
                    AppTextFormField(
                      hintText: LocaleKeys.enter_your_email.tr(),
                      labelText: LocaleKeys.email.tr(),
                      isPassword: false,
                      controller: _viewModel.emailController,
                      validator: (value) => Validations.validateEmail(value),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_24),
                    AppTextFormField(
                      controller: _viewModel.passwordController,
                      isPassword: true,
                      hintText: LocaleKeys.enter_your_password.tr(),
                      labelText: LocaleKeys.password.tr(),
                      suffixIcon: const Icon(Icons.visibility_off),
                      validator: Validations.validatePassword,
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_10),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            value: _viewModel.rememberMe,
                            onChanged: (value) {
                              _viewModel.rememberMe = value ?? false;
                            },
                            title: Text(LocaleKeys.remember_me.tr()),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.forgetPasswordRoute);
                          },
                          child: Text(LocaleKeys.forgot_password.tr()),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_32),
                    CustomButton(
                      onPressed: () {
                        _viewModel.signIn();
                      },
                      borderRadius: AppSizes.borderRadiusFull,
                      child: Text(LocaleKeys.continue_btn.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SignInErrorState) {
          DialogueUtils.showMessage(
            context: context,
            title: LocaleKeys.error.tr(),
            message: state.message,
            posActionName: LocaleKeys.ok.tr(),
          );
        }
        else if (state is SignInSuccessState) {
          DialogueUtils.showMessage(
            context: context,
            title: LocaleKeys.success.tr(),
            message: state.signInResponseEntity.message ?? LocaleKeys.success.tr(),
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              context.pushNamed(AppRoutes.mainLayoutRoute);
            },
          );
        }
      },
    );
  }
}
