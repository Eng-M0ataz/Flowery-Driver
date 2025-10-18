import 'dart:io';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';

abstract class ProfileRemoteDataSource{
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData();
  Future<ApiResult<EditProfileResponseEntity>> editProfile(EditProfileRequestEntity editProfileRequestEntity);
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(File imageFile);
  Future<ApiResult<VehicleResponseEntity>> getVehicle(String vehicleId);
}

