import 'dart:io';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/edit_profile_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/edit_profile_request_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/profile_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/upload_profile_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/vehicle_response_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/upload_photo_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/vehicle_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required ProfileApiService profileApiService})
    : _profileApiService = profileApiService;

  final ProfileApiService _profileApiService;

  @override
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData() async {
    return executeApi<DriverProfileResponseDto, DriverProfileResponseEntity>(
      request: () => _profileApiService.getLoggedDriverData(),
      mapper: (res) => res.toEntity(),
    );
  }

  @override
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
    EditProfileRequestEntity editProfileRequestEntity,
  ) async {
    return executeApi<EditProfileResponseDto, EditProfileResponseEntity>(
      request: () =>
          _profileApiService.editProfile(editProfileRequestEntity.toModel()),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
    File imageFile,
  ) async {
    return executeApi<UploadPhotoResponseDto, UploadPhotoResponseEntity>(
      request: () => _profileApiService.uploadProfilePhoto(imageFile),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicle(String vehicleId) async{
    return executeApi<VehicleResponseDto, VehicleResponseEntity>(
        request: ()=> _profileApiService.getVehicle(vehicleId),
         mapper: (dto) => dto.toEntity(),
    );
  }
}
