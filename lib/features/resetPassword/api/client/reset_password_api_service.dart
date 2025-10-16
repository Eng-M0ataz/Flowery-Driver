import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'reset_password_api_service.g.dart';

@singleton
@RestApi()
abstract class ResetPasswordApiService {
  @factoryMethod
  factory ResetPasswordApiService(Dio dio) = _ResetPasswordApiService;
  @PATCH(ApiConstants.changePassword)
  Future<void> resetPassword(
    @Body() ResetPasswordRequestModel resetPasswordRequestModel,
  );
}
