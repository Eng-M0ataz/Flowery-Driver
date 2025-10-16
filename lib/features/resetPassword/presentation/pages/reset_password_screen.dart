import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/widgets/reset_password_screen_body.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.resetPassword.tr()),
      body: const ResetPasswordScreenBody(),
    );
  }
}
