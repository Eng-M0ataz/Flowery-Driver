import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehicleTypesUseCase {
  GetVehicleTypesUseCase(this._repository);
  final AuthRepo _repository;

  Future<ApiResult<VehicleTypesResponsEntity>> invoke() async {
    return await _repository.getVehicleTypes();
  }
}
