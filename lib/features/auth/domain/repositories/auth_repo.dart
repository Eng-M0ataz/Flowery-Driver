import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );

  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  );

  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
  Future<ApiResult<void>> signUp(SignUpRequestModel signUpRequest);
  
  Future<ApiResult<VehicleTypesResponsEntity>> getVehicleTypes();
  
  Future<VehicleTypesResponsEntity> getVehicleTypesFromLocal();
}
