import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/start_order_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';

extension StartOrderResponseDtoMapper on StartOrderResponseDto {
  StartOrderResponseEntity toEntity() {
    return StartOrderResponseEntity(
      message ?? '',
      orders?.updatedAt ?? '',
      orders?.Id ?? '',
    );
  }
}
