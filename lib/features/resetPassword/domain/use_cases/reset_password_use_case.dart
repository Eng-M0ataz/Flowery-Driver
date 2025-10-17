import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._resetPasswordRepo);

  final ResetPasswordRepo _resetPasswordRepo;

  Future<ApiResult<void>> invoke(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordRepo.resetPassword(resetPasswordRequestModel);
  }
}
