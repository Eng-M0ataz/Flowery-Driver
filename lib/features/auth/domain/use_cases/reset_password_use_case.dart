import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._authRepo);
  final AuthRepo _authRepo;

  Future<ApiResult<ResetPasswordResponseEntity>> invoke(
    ResetPasswordRequestEntity request,
  ) {
    return _authRepo.resetPassword(request);
  }
}
