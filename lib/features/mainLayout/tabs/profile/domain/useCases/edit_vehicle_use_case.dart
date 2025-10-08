import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/requests/edit_vehicle_request_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/edit_vehicle_response_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  // final ProfileRepo _profileRepo;
  // EditProfileUseCase({required this._profileRepo});
  // Future<ApiResult<EditVehicleResponseEntity>> invoke(
  //   EditVehicleRequestEntity editVehicleRequestEntity) {
  //     return _profileRepo.editVehicle(editVehicleRequestEntity);
  //   }

  Future<ApiResult<EditVehicleResponseEntity>> invoke(
    EditVehicleRequestEntity editVehicleRequestEntity,
  ) async {
    return ApiSuccessResult(data: EditVehicleResponseEntity());
  }
}
