import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/forget_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';

extension ForgetPasswordDtoMapper on ForgetPasswordResponseDto {
  ForgetPasswordResponseEntity toEntity() {
    return ForgetPasswordResponseEntity(
      message: message ?? '',
      info: info ?? '',
    );
  }
}
