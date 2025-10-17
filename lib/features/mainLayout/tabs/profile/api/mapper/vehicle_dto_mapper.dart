import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/vehicle_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_entity.dart';

extension VehicleDtoMapper on VehicleDto{
  VehicleEntity toEntity(){
    return VehicleEntity(
      createdAt: createdAt ?? '',
      id: id ?? '',
      image: image ?? '',
      type: type ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}