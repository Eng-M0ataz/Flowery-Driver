import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedUserUseCase {
  GetLoggedUserUseCase(this._profileRepo);
  final ProfileRepo _profileRepo;

  Future<ApiResult<DriverProfileResponseEntity>> invoke() async {
    return await _profileRepo.getLoggedDriverData();
  }
}