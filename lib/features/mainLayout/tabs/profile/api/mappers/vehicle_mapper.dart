
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/vehicle_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/vehicles_entity.dart';

extension VehicleMapper on VehicleDto {
  VehicleEntity toEntity() => VehicleEntity(
    Id: Id ?? '',
    type: type ?? '',
    image: image ?? '',
    createdAt: createdAt ?? '',
    updatedAt: updatedAt ?? '',
  );
}