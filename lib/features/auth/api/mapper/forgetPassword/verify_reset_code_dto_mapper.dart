import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/verify_reset_code_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';

extension VerifyResetCodeDtoMapper on VerifyResetCodeResponseDto {
  VerifyResetCodeResponseEntity toEntity() {
    return VerifyResetCodeResponseEntity(status: status ?? '');
  }
}
