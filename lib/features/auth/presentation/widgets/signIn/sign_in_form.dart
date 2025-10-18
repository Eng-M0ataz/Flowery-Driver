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
import 'package:flowery_tracking/features/auth/presentation/widgets/signIn/custom_password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInViewModel>(),
      child: const _SignInFormContent(),
    );
  }
}

class _SignInFormContent extends StatefulWidget {
  const _SignInFormContent({super.key});

  @override
  State<_SignInFormContent> createState() => _SignInFormContentState();
}

class _SignInFormContentState extends State<_SignInFormContent> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInViewModel, SignInState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              TextFormField(
                controller: _emailController,
                obscureText: false,
                validator: (value) => Validations.validateEmail(value),
                decoration: InputDecoration(
                  hintText: LocaleKeys.enter_your_email.tr(),
                  labelText: LocaleKeys.email.tr(),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              CustomPasswordTextFormField(
                controller: _passwordController,
                hint: LocaleKeys.enter_your_password.tr(),
                label: LocaleKeys.password.tr(),
                validator: (value) => Validations.validatePassword(value),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_10),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: state.isRememberMe,
                      onChanged: (value) {
                        context.read<SignInViewModel>().doIntent(
                          event: ToggleRememberMeEvent(
                            isRememberMe: value ?? false,
                          ),
                        );
                      },
                      title: Text(LocaleKeys.remember_me.tr()),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<SignInViewModel>().doIntent(
                        event: NavigationEvent(
                          context: context,
                          appRoute: AppRoutes.forgetPasswordRoute,
                        ),
                      );
                    },
                    child: Text(LocaleKeys.forgot_password.tr(), style: Theme.of(context).textTheme.labelSmall!.copyWith(decoration: TextDecoration.underline),),
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
                          state.failure?.errorMessage ?? LocaleKeys.error.tr(),
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
                      if (_formKey.currentState!.validate()) {
                        context.read<SignInViewModel>().doIntent(
                          event: SignInEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
