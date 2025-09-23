import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);

  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<ApiResult<SignInResponseEntity>> signIn({
    required SignInRequestEntity requestEntity,
    bool? rememberMeChecked = false,
  }) async {
    final ApiResult<SignInResponseEntity> result = await _authRemoteDataSource
        .signIn(requestEntity: requestEntity);
    if (result is ApiSuccessResult<SignInResponseEntity>) {
      final String? token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await _authLocalDataSource.writeToken(token: token);

        // If user checked "Remember Me"
        if (rememberMeChecked!) {
          await _authLocalDataSource.setRememberMe(rememberMe: true);
        }
      }
    }
    return result;
  }
}
