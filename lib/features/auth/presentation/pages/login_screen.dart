import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
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
    return BlocProvider(
      create: (context) =>  _viewModel,
      child:
         Scaffold(
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
                    TextFormField(
                      controller:  _viewModel.emailController,
                      obscureText: false,
                      validator: (value) => Validations.validateEmail(value),
                      decoration: InputDecoration(
                        hintText:  LocaleKeys.enter_your_email.tr(),
                        labelText: LocaleKeys.email.tr(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_24),
                    TextFormField(
                      controller: _viewModel.passwordController,
                      obscureText: _viewModel.obscureText,
                      validator: (value) => Validations.validatePassword(value),
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_your_password.tr(),
                        labelText: LocaleKeys.password.tr(),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _viewModel.obscureText = !_viewModel.obscureText;
                          });
                        }, icon: Icon(_viewModel.obscureText ? Icons.visibility_off : Icons.visibility))
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_10),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            value: _viewModel.rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _viewModel.toggleRememberMe(value ?? false);
                              });
                            },
                            title: Text(LocaleKeys.remember_me.tr()),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,

                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _viewModel.navigateToRouteScreen(context, AppRoutes.forgetPasswordRoute);
                          },
                          child: Text(LocaleKeys.forgot_password.tr()),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_32),
                    BlocConsumer<SignInViewModel, SignInState>(
                      bloc: _viewModel,
                      listener: (context, state) {
                        if (state.failure != null) {
                          DialogueUtils.showMessage(
                            context: context,
                            title: LocaleKeys.error.tr(),
                            message: state.failure?.errorMessage ?? LocaleKeys.error.tr(),
                            posActionName: LocaleKeys.ok.tr(),
                          );
                        }
                        if (state.response != null) {
                          context.pushNamedAndRemoveUntil(AppRoutes.mainLayoutRoute,
                              predicate: (route) => false);
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state.isLoading;
                        return CustomElevatedButton(
                          widget: Text(LocaleKeys.login.tr()),
                          isLoading: isLoading,
                          onPressed: () {
                            _viewModel.signIn();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
