import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

abstract interface class AuthLocalDataSource {
  Future<ApiResult<void>> writeToken({required String token});
  Future<ApiResult<void>> setRememberMe({required bool rememberMe});
  Future<bool> getRememberMe();
  Future<VehicleTypesResponsEntity> loadVehicleList();
}