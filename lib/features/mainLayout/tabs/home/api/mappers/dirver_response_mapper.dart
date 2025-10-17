import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/driver_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/driver_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';


extension DirverResponseMapper on DriverResponseDto {
  DriverResponseEntity toEntity() {
    return DriverResponseEntity(
      driver:
          driver?.toEntity() ??
          const DriverEntity(
            country: 'country',
            email: 'email',
            firstName: 'firstName',
            gender: 'gender',
            id: 'id',
            lastName: 'lastName',
            nationalId: 'nid',
            nationalIdImage: 'nidImg',
            phone: 'phone',
            photo: 'photo',
            role: 'role',
            vehicleLicense: 'vehicleLicense',
            vehicleNumber: 'vehicleNumber',
            vehicleType: 'vehicleType',
          ),
    );
  }
}

extension DriverEntityMapper on DriverDto {
  DriverEntity toEntity() {
    return DriverEntity(
      country: country,
      email: email,
      firstName: firstName,
      gender: gender,
      id: id,
      lastName: lastName,
      nationalId: nid,
      nationalIdImage: nidImg,
      phone: phone,
      photo: photo,
      role: role,
      vehicleLicense: vehicleLicense,
      vehicleNumber: vehicleNumber,
      vehicleType: vehicleType,
    );
  }
}
