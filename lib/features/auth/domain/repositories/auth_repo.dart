import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<SignInResponseEntity>> signIn({
    required SignInRequestEntity requestEntity,
    bool? rememberMeChecked,
  });
}
