
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllVehiclesUseCase {
  GetAllVehiclesUseCase(this._profileRepo);
  final ProfileRepo _profileRepo;
  Future<ApiResult<GetAllVehiclesResponseEntity>> getAllVehicles() {
    return _profileRepo.getAllVehicles();
  }
}