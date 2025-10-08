
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/driver_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/driver_data_entity.dart';

extension DriverDataMapper on DriverDataDto {
  DriverDataEntity toEntity() => DriverDataEntity(
    role: role ?? '',
    Id: Id ?? '',
    country: country ?? '',
    firstName: firstName ?? '',
    lastName: lastName ?? '',
    vehicleType: vehicleType ?? '',
    vehicleNumber: vehicleNumber ?? '',
    vehicleLicense: vehicleLicense ?? '',
    NID: NID ?? '',
    NIDImg: NIDImg ?? '',
    email: email ?? '',
    gender: gender ?? '',
    phone: phone ?? '',
    photo: photo ?? '',
    createdAt: createdAt ?? ''
  );
}