import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
//
// sealed class SignInStates{}
//
// class SignInInitState extends SignInStates{}
//
// class SignInLoadingState extends SignInStates{}
//
// class SignInSuccessState extends SignInStates{
//   SignInSuccessState(this.signInResponseEntity);
//   SignInResponseEntity signInResponseEntity;
// }
//
// class SignInErrorState extends SignInStates{
//   SignInErrorState(this.message);
//   final String message;
// }



class SignInState {

  SignInState({
    this.response,
    this.failure,
    this.isLoading = false
  });
  SignInResponseEntity? response;
  Failure? failure;
  bool isLoading;

  SignInState copyWith({
    SignInResponseEntity? response,
    Failure? failure,
    bool? isLoading,
  }) {
    return SignInState(
        response: response ?? this.response,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading
    );
  }
}