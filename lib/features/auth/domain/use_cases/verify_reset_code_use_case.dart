import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeUseCase {
  VerifyResetCodeUseCase(this._authRepo);
  final AuthRepo _authRepo;

  Future<ApiResult<VerifyResetCodeResponseEntity>> invoke(
    VerifyResetCodeRequestEntity resetCode,
  ) {
    return _authRepo.verifyResetCode(resetCode);
  }
}
