import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/update_order_state_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/update_order_state_response_entity.dart';

extension UpdateOrderStateResponseDtoMapper on UpdateOrderStateResponseDto {
  UpdateOrderStateResponseEntity toEntity() {
    return UpdateOrderStateResponseEntity(message: message ?? '');
  }
}
