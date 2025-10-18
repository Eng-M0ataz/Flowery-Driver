import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/edit_driver_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_driver_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';

extension EditProfileDtoMapper on EditProfileResponseDto{
  EditProfileResponseEntity toEntity(){
    return EditProfileResponseEntity(
      message: message ?? '',
      driver: driver?.toEntity() ?? EditDriverEntity(role: '', id: '', country: '', firstName: '', lastName: '', vehicleType: '', vehicleNumber: '', vehicleLicense: '', nID: '', nIDImg: '', email: '', password: '', gender: '', phone: '', photo: '', createdAt: '')
    );
  }
}