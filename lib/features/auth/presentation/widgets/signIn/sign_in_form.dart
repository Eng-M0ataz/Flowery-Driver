import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late SignInViewModel _signInViewModel;

  @override
  void initState() {
    _signInViewModel = getIt<SignInViewModel>();
    _signInViewModel.doIntent(event: SignInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _signInViewModel,
      child: BlocBuilder<SignInViewModel, SignInState>(
        builder: (context, state) {
          return Form(
            key: _signInViewModel.formKey,
            child: ListView(
              children: [
                const SizedBox(height: AppSizes.spaceBetweenItems_24),
                TextFormField(
                  controller: _signInViewModel.emailController,
                  obscureText: false,
                  validator: (value) => Validations.validateEmail(value),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.enter_your_email.tr(),
                    labelText: LocaleKeys.email.tr(),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_24),
                TextFormField(
                  controller: _signInViewModel.passwordController,
                  obscureText: state.obscureText,
                  validator: (value) => Validations.validatePassword(value),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.enter_your_password.tr(),
                    labelText: LocaleKeys.password.tr(),
                    suffixIcon: IconButton(
                      onPressed: _signInViewModel.togglePasswordVisibility,
                      icon: Icon(
                        state.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_10),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        value: state.isRememberMe,
                        onChanged: (value) {
                          _signInViewModel.toggleRememberMe(value ?? false);
                        },
                        title: Text(LocaleKeys.remember_me.tr()),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _signInViewModel.navigateToRouteScreen(
                          context,
                          AppRoutes.forgetPasswordRoute,
                        );
                      },
                      child: Text(LocaleKeys.forgot_password.tr()),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_32),
                BlocConsumer<SignInViewModel, SignInState>(
                  listener: (context, state) {
                    if (state.failure != null) {
                      DialogueUtils.showMessage(
                        context: context,
                        title: LocaleKeys.error.tr(),
                        message:
                            state.failure?.errorMessage ??
                            LocaleKeys.error.tr(),
                        posActionName: LocaleKeys.ok.tr(),
                      );
                    }
                    if (state.response != null) {
                      context.pushNamedAndRemoveUntil(
                        AppRoutes.mainLayoutRoute,
                        predicate: (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.isLoading;
                    return CustomElevatedButton(
                      widget: Text(LocaleKeys.login.tr()),
                      isLoading: isLoading,
                      onPressed: () {
                        _signInViewModel.doIntent(event: SignInEvent());
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
