import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  ForgetPasswordUseCase(this._authRepo);
  final AuthRepo _authRepo;

  Future<ApiResult<ForgetPasswordResponseEntity>> invoke(
    ForgetPasswordRequestEntity request,
  ) {
    return _authRepo.forgetPassword(request);
  }
}
