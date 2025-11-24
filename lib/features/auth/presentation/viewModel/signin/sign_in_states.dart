import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
class SignInState {

  SignInState({
    this.response,
    this.failure,
    this.obscureText = true,
    this.isLoading = false,
    this.isRememberMe = false,
    this.isSuc = false,

  });
  SignInResponseEntity? response;
  Failure? failure;
  bool isLoading;
  bool isRememberMe;
  bool obscureText;
  bool isSuc;


  SignInState copyWith({
    SignInResponseEntity? response,
    Failure? failure,
    bool? isLoading,
    bool? isRememberMe,
    bool? obscureText,
    bool? isSuc,
  }) {
    return SignInState(
        response: response ?? this.response,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading,
        isRememberMe: isRememberMe ?? this.isRememberMe,
        obscureText: obscureText ?? this.obscureText,

    );
  }
}