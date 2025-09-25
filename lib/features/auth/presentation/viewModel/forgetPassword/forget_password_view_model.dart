import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_event.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  final forgetPasswordKey = GlobalKey<FormState>();
  final verifyCodeKey = GlobalKey<FormState>();
  final resetPasswordKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    codeController.dispose();
    return super.close();
  }

  Future<void> doIntent(ForgetPasswordEvent intent) async {
    switch (intent) {
      case SendForgetRequestEvent():
        await _sendForgetRequest(emailController.text);
        break;
      case VerifyCodeEvent():
        await _verifyCode(codeController.text);
        break;
      case ResendCodeEvent():
        await _resendCode();
        break;
      case ResetPasswordEvent():
        await _resetPassword(newPasswordController.text);
        break;
      case ResendTimerFinishedEvent():
        await _onResendTimerFinished();
        break;
    }
  }

  Future<void> _onResendTimerFinished() async {
    emit(state.copyWith(isResendAvailable: true));
  }

  Future<void> _sendForgetRequest(String email) async {
    if (!forgetPasswordKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _forgetPasswordUseCase.invoke(
      ForgetPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            step: ForgetPasswordStep.verify,
            status: ForgetPasswordStatus.success,
            email: email,
            forgetResponse: result.data,
            mainTimerEndTime: DateTime.now().add(const Duration(minutes: 10)),
          ),
        );
        break;

      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.error,
            failure: result.failure,
          ),
        );
        break;
    }
  }

  Future<void> _verifyCode(String code) async {
    if (!verifyCodeKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _verifyResetCodeUseCase.invoke(
      VerifyResetCodeRequestEntity(resetCode: code),
    );

    switch (result) {
      case ApiSuccessResult<VerifyResetCodeResponseEntity>():
        emit(
          state.copyWith(
            step: ForgetPasswordStep.reset,
            status: ForgetPasswordStatus.success,
            verifyResponse: result.data,
          ),
        );
        break;

      case ApiErrorResult<VerifyResetCodeResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.error,
            failure: result.failure,
          ),
        );
        break;
    }
  }

  Future<void> _resendCode() async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _forgetPasswordUseCase.invoke(
      ForgetPasswordRequestEntity(email: state.email!),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.success,
            forgetResponse: result.data,
            step: ForgetPasswordStep.resend,
            isResendAvailable: false,
            mainTimerEndTime: DateTime.now().add(const Duration(minutes: 10)),
          ),
        );
        break;

      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.error,
            failure: result.failure,
          ),
        );
        break;
    }
  }

  Future<void> _resetPassword(String newPassword) async {
    if (!resetPasswordKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _resetPasswordUseCase.invoke(
      ResetPasswordRequestEntity(email: state.email!, newPassword: newPassword),
    );

    switch (result) {
      case ApiSuccessResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.success,
            resetResponse: result.data,
          ),
        );
        break;

      case ApiErrorResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: ForgetPasswordStatus.error,
            failure: result.failure,
          ),
        );
        break;
    }
  }
}
