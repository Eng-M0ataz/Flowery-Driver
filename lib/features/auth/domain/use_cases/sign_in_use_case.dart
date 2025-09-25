import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  SignInUseCase({required this.authRepo});

  AuthRepo authRepo;

  Future<ApiResult<SignInResponseEntity>> call({
    required SignInRequestEntity requestEntity,
    bool? rememberMeChecked = false,
  }) async {
    return await authRepo.signIn(
      requestEntity: requestEntity,
      rememberMeChecked: rememberMeChecked,
    );
  }
}
