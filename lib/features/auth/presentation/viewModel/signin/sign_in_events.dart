import 'package:flutter/material.dart';

sealed class SignInEvents {}
class SignInEvent extends SignInEvents {

  SignInEvent({required this.email, required this.password});
  final String email;
  final String password;
}
class TogglePasswordEvent extends SignInEvents {}
class ToggleRememberMeEvent extends SignInEvents {
  ToggleRememberMeEvent({required this.isRememberMe});
  bool isRememberMe;

}
class NavigationEvent extends SignInEvents {
  NavigationEvent({required this.context, required this.appRoute});
  final BuildContext context;
  final String appRoute;
}

