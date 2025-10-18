import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/location_entity.dart';

class DriverEntity {

  const DriverEntity({
    this.driverLocation,
    this.firstName,
    this.lastName,
    this.phone,
    this.driverPhotoUrl,
  });
  final LocationEntity? driverLocation;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? driverPhotoUrl;
}
