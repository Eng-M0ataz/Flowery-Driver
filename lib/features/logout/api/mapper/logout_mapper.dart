import 'package:flowery_tracking/features/logout/api/models/response/logout_response_dto.dart';
import 'package:flowery_tracking/features/logout/domain/entities/logout_response_entity.dart';

extension LogoutMapper on LogoutResponseDto {
  LogoutResponseEntity toEntity() {
    return LogoutResponseEntity(message: message??" ");
  }
}