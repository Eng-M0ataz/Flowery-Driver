import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';

sealed class SignInStates{}

class SignInInitState extends SignInStates{}

class SignInLoadingState extends SignInStates{}

class SignInSuccessState extends SignInStates{
  SignInSuccessState(this.signInResponseEntity);
  SignInResponseEntity signInResponseEntity;
}

class SignInErrorState extends SignInStates{
  SignInErrorState(this.message);
  final String message;
}