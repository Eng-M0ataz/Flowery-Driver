import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/requestes/edit_profile_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/upload_photo_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_service.g.dart';

@singleton
@RestApi()
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(ApiConstants.getLoggedDriverData)
  Future<DriverProfileResponseDto> getLoggedDriverData();

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponseDto> editProfile(
      @Body() EditProfileRequestModel editProfileRequestModel
      );

  @PUT(ApiConstants.uploadPhoto)
  @MultiPart()
  Future<UploadPhotoResponseDto> uploadProfilePhoto(
      @Part(name: 'photo') File photo
      );
}
