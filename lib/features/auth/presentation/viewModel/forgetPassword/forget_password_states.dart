import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';

enum ForgetPasswordStep { forget, verify, reset, resend }

enum ForgetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.step = ForgetPasswordStep.forget,
    this.status = ForgetPasswordStatus.initial,
    this.isResendAvailable = true,
    this.failure,
    this.email,
    this.forgetResponse,
    this.verifyResponse,
    this.resetResponse,
  });

  final ForgetPasswordStep step;
  final ForgetPasswordStatus status;
  final Failure? failure;
  final bool isResendAvailable;
  final String? email;
  final ForgetPasswordResponseEntity? forgetResponse;
  final VerifyResetCodeResponseEntity? verifyResponse;
  final ResetPasswordResponseEntity? resetResponse;

  ForgetPasswordState copyWith({
    ForgetPasswordStep? step,
    ForgetPasswordStatus? status,
    Failure? failure,
    bool? isResendAvailable,
    String? email,
    ForgetPasswordResponseEntity? forgetResponse,
    VerifyResetCodeResponseEntity? verifyResponse,
    ResetPasswordResponseEntity? resetResponse,
  }) {
    return ForgetPasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      email: email ?? this.email,
      forgetResponse: forgetResponse ?? this.forgetResponse,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      resetResponse: resetResponse ?? this.resetResponse,
      isResendAvailable: isResendAvailable ?? this.isResendAvailable,
    );
  }

  @override
  List<Object?> get props => [
    step,
    status,
    failure,
    email,
    forgetResponse,
    verifyResponse,
    resetResponse,
    isResendAvailable,
  ];
}
