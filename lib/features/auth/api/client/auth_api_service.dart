import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/request/sign_in_request_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/forget_password_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/reset_password_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/request/verify_reset_code_request.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/forget_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/reset_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/verify_reset_code_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service.g.dart';

@singleton
@RestApi()
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiConstants.signIn)
  Future<SignInResponseDto>signIn({@Body() required SignInRequestDto requestDto});

  @POST(ApiConstants.forgotPassword)
  Future<ForgetPasswordResponseDto> forgetPassword(
    @Body() ForgetPasswordRequest forgetPasswordRequest,
  );

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyResetCodeResponseDto> verifyResetCode(
    @Body() VerifyResetCodeRequest verifyResetCodeRequest,
  );

  @PUT(ApiConstants.changePassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequest resetPasswordRequest,
  );
  @POST(ApiConstants.signUp)
  Future<void> signUp(@Body() FormData formData);
  @GET(ApiConstants.vehicles)
  Future<VehicleTypesResponseDto> getVehicleTypes();
}
