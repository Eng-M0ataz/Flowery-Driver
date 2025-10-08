import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/upload_vehicle_license_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  // final ProfileRepo _profileRepo;
  // UploadPhotoUseCase({required this._profileRepo});
  // Future<ApiResult<UploadVehicleLicenseEntity>> invoke(
  //     UploadVehicleLicenseEntity uploadVehicleLicenseEntity) {
  //     return _profileRepo.uploadImage(uploadVehicleLicenseEntity);
  //   }

  Future<ApiResult<UploadVehicleLicenseEntity>> invoke(
    String? vehicleLicense,
  ) async {
    return ApiSuccessResult(
      data: UploadVehicleLicenseEntity(
        vehicleLicense: vehicleLicense != null ? File(vehicleLicense) : null,
      ),
    );
  }
}
