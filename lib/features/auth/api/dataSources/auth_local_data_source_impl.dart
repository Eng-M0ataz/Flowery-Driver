import 'dart:convert';

import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signUp/response/vehicle_type_mapper.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(@Named(AppConstants.secureStorage) this._storage);
  // ignore: unused_field
  final Storage _storage;

  @override
  Future<VehicleTypesResponsEntity> loadVehicleList() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.vehicleMapPath,
    );
    final Map<String, dynamic> data = json.decode(jsonString);
    final VehicleTypesResponseDto vehicleTypesResponseDto =
        VehicleTypesResponseDto.fromJson(data);

    final VehicleTypesResponsEntity vehicleTypesResponsEntity =
        vehicleTypesResponseDto.toEntity();

    return vehicleTypesResponsEntity;
  }
}
