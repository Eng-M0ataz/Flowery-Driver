import 'dart:io';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase{
  UploadPhotoUseCase({required ProfileRepo profileRepo}) : _profileRepo = profileRepo;
  final ProfileRepo _profileRepo;

  Future<ApiResult<UploadPhotoResponseEntity>> invoke (File imageFile){
    return _profileRepo.uploadProfilePhoto(imageFile);
  }

}