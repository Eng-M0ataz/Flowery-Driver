import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_response_entity.dart';

extension DriverDtoMapper on DriverDto{
  DriverEntity toEntity(){
    return DriverEntity(
      country: country,
      email: email,
      firstName: firstName,
      gender: gender,
      Id: Id,
      lastName: lastName,
      NID: NID,
      NIDImg: NIDImg,
      phone: phone,
      photo: photo,
      role: role,
      vehicleLicense: vehicleLicense,
      vehicleNumber: vehicleNumber,
      vehicleType: vehicleType,
      createdAt: createdAt,

    );
  }
}
