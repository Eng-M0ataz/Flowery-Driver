import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
class SignInState {

  SignInState({
    this.response,
    this.failure,
    this.isLoading = false,
    this.isRememberMe = false
  });
  SignInResponseEntity? response;
  Failure? failure;
  bool isLoading;
  bool isRememberMe;


  SignInState copyWith({
    SignInResponseEntity? response,
    Failure? failure,
    bool? isLoading,
    bool? isRememberMe,
  }) {
    return SignInState(
        response: response ?? this.response,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading,
        isRememberMe: isRememberMe ?? this.isRememberMe
    );
  }
}