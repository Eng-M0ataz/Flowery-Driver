import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BuildConfirmPasswordField extends StatelessWidget {
  const BuildConfirmPasswordField({
    super.key,
    required this.confirmController,
    required this.passwordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: confirmController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        labelText: LocaleKeys.confirmPassword.tr(),
        hintText: LocaleKeys.confirmPassword.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (val) =>
          Validations.validateConfirmPassword(val, passwordController.text),
    );
  }
}
