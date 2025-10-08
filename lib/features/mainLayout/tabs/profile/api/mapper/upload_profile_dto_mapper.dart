import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/upload_photo_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';

extension UploadProfileDtoMapper on UploadPhotoResponseDto{
  UploadPhotoResponseEntity toEntity(){
    return UploadPhotoResponseEntity(
      message: message
    );
  }
}