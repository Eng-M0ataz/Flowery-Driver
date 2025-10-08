import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/driver_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';

extension ProfileDtoMapper on DriverProfileResponseDto{
  DriverProfileResponseEntity toEntity(){
    return DriverProfileResponseEntity(driver: driver?.toEntity(), message:message);
  }
}
