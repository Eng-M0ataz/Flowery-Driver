
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mappers/driver_data_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_driver_data_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';

extension GetDriverDataResponseMapper on GetDriverDataResponseDto{
  GetDriverDataResponseEntity toEntity() {
    return GetDriverDataResponseEntity(
      message: message,
      driver: driver?.toEntity(),
    );

  }
}