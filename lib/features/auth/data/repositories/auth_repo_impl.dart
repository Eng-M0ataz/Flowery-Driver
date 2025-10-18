import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
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
    final ApiResult<SignInResponseEntity> result = await _authRemoteDataSource.signIn(requestEntity: requestEntity);
    if (result is ApiSuccessResult<SignInResponseEntity>) {
      final String? token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await _authLocalDataSource.writeToken(token: token);

        if (rememberMeChecked!) {
          await _authLocalDataSource.setRememberMe(rememberMe: true);
        }
      }
    }
    return result;
  }

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.forgetPassword(request);
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  ) {
    return _authRemoteDataSource.verifyResetCode(request);
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.resetPassword(request);
  }

  @override
  Future<ApiResult<void>> signUp(SignUpRequestModel signUpRequest) {
    return _authRemoteDataSource.signUp(signUpRequest);
  }

  @override
  Future<ApiResult<VehicleTypesResponsEntity>> getVehicleTypes() async {
    return await _authRemoteDataSource.getVehicleTypes();
  }

  @override
  Future<VehicleTypesResponsEntity> getVehicleTypesFromLocal() async {
    return await _authLocalDataSource.loadVehicleList();
  }
}
