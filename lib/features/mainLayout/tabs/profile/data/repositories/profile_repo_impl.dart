import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo{
  ProfileRepoImpl({required ProfileRemoteDataSource profileRemoteDataSource}) : _profileRemoteDataSource = profileRemoteDataSource;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  @override
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData() {
    return _profileRemoteDataSource.getLoggedDriverData();
  }

  @override
  Future<ApiResult<EditProfileResponseEntity>> editProfile(EditProfileRequestEntity editProfileRequestEntity) {
    return _profileRemoteDataSource.editProfile(editProfileRequestEntity);
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(File imageFile) {
    return _profileRemoteDataSource.uploadProfilePhoto(imageFile);

  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicle(String vehicleId) {
    return _profileRemoteDataSource.getVehicle(vehicleId);

  }
}