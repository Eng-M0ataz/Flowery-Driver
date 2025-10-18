import 'package:flowery_tracking/features/pickupLocation/data/mapper/request/location_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/driver_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/driver_entity.dart';

extension DriverMapper on DriverModel {
  DriverEntity toEntity() {
    return DriverEntity(
      driverLocation: driverLocation?.toEntity(),
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      driverPhotoUrl: driverPhotoUrl,
    );
  }
}

extension DriverModelMapper on DriverEntity {
  DriverModel toModel() {
    return DriverModel(
      driverLocation: driverLocation?.toModel(),
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      driverPhotoUrl: driverPhotoUrl,
    );
  }
}
