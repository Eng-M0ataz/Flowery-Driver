import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_response_entity.dart';

extension DriverDtoMapper on DriverDto{
  DriverEntity toEntity(){
    return DriverEntity(
      country: country ?? '',
      email: email ?? '',
      firstName: firstName ?? '',
      gender: gender ?? '',
      id: id ?? '',
      lastName: lastName ?? '',
      nID: nID ?? '',
      nIDImg: nIDImg ?? '',
      phone: phone ?? '',
      photo: photo ?? '',
      role: role ?? '',
      vehicleLicense: vehicleLicense ?? '',
      vehicleNumber: vehicleNumber ?? '',
      vehicleType: vehicleType ?? '',
      createdAt: createdAt ?? '',

    );
  }
}
