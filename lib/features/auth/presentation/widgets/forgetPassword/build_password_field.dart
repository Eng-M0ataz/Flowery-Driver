import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/Functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {
  const BuildPasswordField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: LocaleKeys.password.tr(),
        hintText: LocaleKeys.enterPassword.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validatePassword,
    );
  }
}
