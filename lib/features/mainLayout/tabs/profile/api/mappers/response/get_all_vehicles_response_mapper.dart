
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mappers/meta_data_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mappers/vehicle_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_all_vehicles_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';

extension GetAllVehiclesResponseMapper on GetAllVehiclesResponseDto {
  GetAllVehiclesResponseEntity toEntity() {
    return GetAllVehiclesResponseEntity(
      message: message,
      metadata: metadata?.toEntity(),
      vehicles: vehicles?.map((e) => e.toEntity()).toList(),
    );
  }
}