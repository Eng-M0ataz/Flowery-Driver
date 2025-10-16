import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/sign_up_screen_body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.apply.tr()),
      body: SignUpScreenBody(),
    );
  }
}
