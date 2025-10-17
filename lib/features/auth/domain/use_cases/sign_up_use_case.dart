import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  SignUpUseCase(this._authRepo);

  final AuthRepo _authRepo;

  Future<ApiResult<void>> invoke(SignUpRequestModel signUpRequest) async {
    return await _authRepo.signUp(signUpRequest);
  }
}
