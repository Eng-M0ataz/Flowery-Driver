import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_type_model.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

extension VehicleTypeMapper on VehicleTypesResponseDto {
  VehicleTypesResponsEntity toEntity() {
    return VehicleTypesResponsEntity(
      vehicles: vehicles?.map((vehicle) => vehicle.toEntity()).toList() ?? [],
    );
  }
}

extension VehicleTypeItemMapper on VehicleTypeModel {
  VehicleTypeEntity toEntity() {
    return VehicleTypeEntity(id: id ?? '', type: type ?? '');
  }
}
