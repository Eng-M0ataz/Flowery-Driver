import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_driver_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_driver_entity.dart';

extension EditDriverDtoMapper on EditDriverDto{
  EditDriverEntity toEntity (){
    return EditDriverEntity(
      createdAt: createdAt ?? '',
      country: country ?? '',
      email: email ?? '',
      firstName: firstName ?? '',
      gender: gender ?? '',
      id: id ?? '',
      lastName: lastName ?? '',
      nID: nID ?? '',
      nIDImg: nIDImg ?? '',
      password: password ?? '',
      phone: phone ?? '',
      photo: photo ?? '',
      role: role ?? '',
      vehicleLicense: vehicleLicense ?? '',
      vehicleNumber: vehicleNumber ?? '',
      vehicleType: vehicleType ?? ''
    );
  }
}