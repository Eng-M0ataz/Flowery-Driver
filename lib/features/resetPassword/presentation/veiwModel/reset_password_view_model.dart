import 'package:bloc/bloc.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_event.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_stats.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  ResetPasswordViewModel(this._resetPasswordUseCase)
    : super(const ResetPasswordState());
  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> doIntent({
    required ResetPasswordEvents event,
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    switch (event) {
      case ResetPasswordEvent():
        await _resetPassword(resetPasswordRequestModel);
    }
  }

  Future<void> _resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _resetPasswordUseCase.invoke(
      resetPasswordRequestModel,
    );

    switch (result) {
      case ApiSuccessResult<void>():
        emit(state.copyWith(isLoading: false, resetPasswordSuccess: true));

      case ApiErrorResult<void>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
            resetPasswordSuccess: false,
          ),
        );
    }
  }
}
