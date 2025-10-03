import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<VehicleTypesResponsEntity> loadVehicleList();
}
