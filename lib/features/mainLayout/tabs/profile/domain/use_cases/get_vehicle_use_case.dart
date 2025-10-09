import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVehicleUseCase{
  GetVehicleUseCase(this._profileRepo);
  final ProfileRepo _profileRepo;

  Future<ApiResult<VehicleResponseEntity>> call(String vehicleId) async {
    return await _profileRepo.getVehicle(vehicleId);
  }

}