import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/vehicle_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/vehicle_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';

extension VehicleResponseDtoMapper on VehicleResponseDto{
  VehicleResponseEntity toEntity(){
    return VehicleResponseEntity(
      message: message ?? '',
      vehicle: vehicle?.toEntity() ?? VehicleEntity(createdAt: '', id: '', image: '', type: '', updatedAt: ''),
    );
  }
}