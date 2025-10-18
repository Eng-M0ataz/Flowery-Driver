import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  const BuildEmailField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: LocaleKeys.email.tr(),
        hintText: LocaleKeys.enterEmail.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validateEmail,
    );
  }
}
