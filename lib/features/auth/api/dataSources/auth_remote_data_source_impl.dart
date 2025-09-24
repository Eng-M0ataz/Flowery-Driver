import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/mapper/forgetPassword/forget_password_dto_mapper.dart';
import 'package:flowery_tracking/features/auth/api/mapper/forgetPassword/reset_password_dto_mapper.dart';
import 'package:flowery_tracking/features/auth/api/mapper/forgetPassword/verify_reset_code_dto_mapper.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/forget_password_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/reset_password_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/verify_reset_code_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/forget_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/reset_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/verify_reset_code_response_dto.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiServices);
  final AuthApiService _apiServices;
  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    final dto = ForgetPasswordRequest.fromDomain(request);
    return executeApi<ForgetPasswordResponseDto, ForgetPasswordResponseEntity>(
      request: () => _apiServices.forgetPassword(dto),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  ) async {
    final dto = VerifyResetCodeRequest.fromDomain(request);
    return executeApi<
      VerifyResetCodeResponseDto,
      VerifyResetCodeResponseEntity
    >(
      request: () => _apiServices.verifyResetCode(dto),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    final dto = ResetPasswordRequest.fromDomain(request);
    return executeApi<ResetPasswordResponseDto, ResetPasswordResponseEntity>(
      request: () => _apiServices.resetPassword(dto),
      mapper: (response) => response.toEntity(),
    );
  }
}
