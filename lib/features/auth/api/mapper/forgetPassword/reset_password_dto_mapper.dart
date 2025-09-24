import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/reset_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';

extension ResetPasswordDtoMapper on ResetPasswordResponseDto {
  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(
      message: message ?? '',
      token: token ?? '',
    );
  }
}
