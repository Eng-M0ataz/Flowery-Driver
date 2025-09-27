import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  SignInUseCase({required AuthRepo authRepo}): _authRepo = authRepo;

  final AuthRepo _authRepo;

  Future<ApiResult<SignInResponseEntity>> invoke({
    required SignInRequestEntity requestEntity,
    bool rememberMeChecked = false,
  }) async {
    return await _authRepo.signIn(
      requestEntity: requestEntity,
      rememberMeChecked: rememberMeChecked,
    );
  }
}
