import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_view_model.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/widgets/custom_button_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreenBody extends StatefulWidget {
  const ResetPasswordScreenBody({super.key});

  @override
  State<ResetPasswordScreenBody> createState() =>
      _ResetPasswordScreenBodyState();
}

late TextEditingController _currentPasswordController;
late TextEditingController _newPasswordController;
late TextEditingController _confirmPasswordController;
late ResetPasswordViewModel _resetPasswordViewModel;
late GlobalKey<FormState> _formKey;

class _ResetPasswordScreenBodyState extends State<ResetPasswordScreenBody> {
  @override
  void initState() {
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _resetPasswordViewModel = getIt<ResetPasswordViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: BlocProvider.value(
        value: _resetPasswordViewModel,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: AppSizes.spaceBetweenItems_36),
              TextFormField(
                controller: _currentPasswordController,
                validator: (value) => Validations.validatePassword(value),
                decoration: InputDecoration(
                  hintText: LocaleKeys.currentPassword.tr(),
                  labelText: LocaleKeys.currentPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              TextFormField(
                validator: (value) => Validations.validatePassword(value),
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.newPassword.tr(),
                  labelText: LocaleKeys.currentPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              TextFormField(
                validator: (value) => Validations.validateConfirmPassword(
                  value,
                  _newPasswordController.text,
                ),
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: LocaleKeys.confirmPassword.tr(),
                  labelText: LocaleKeys.currentPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_48),
              CuustomButtonBlocConsumer(
                currentPasswordController: _currentPasswordController,
                newPasswordController: _newPasswordController,
                resetPasswordViewModel: _resetPasswordViewModel,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
