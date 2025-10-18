import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';

abstract interface class ResetPasswordRepo {
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  );
}
