import 'package:flowery_tracking/features/pickupLocation/api/models/responses/location_response_dto.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';

extension LocationResponseMapper on LocationResponseDto {
  LocationResponseEntity toEntity() {
    return LocationResponseEntity(
      driver: driver?.toEntity(),
      store: store?.toEntity(),
      user: user?.toEntity(),
    );
  }
}

extension DriverMapper on DriverDto {
  DriverEntity toEntity() {
    return DriverEntity(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      photo: photo,
      location: location?.toEntity(),
    );
  }
}

extension StoreMapper on StoreDto {
  StoreEntity toEntity() {
    return StoreEntity(
      location: location?.toEntity(),
    );
  }
}

extension UserMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      location: location?.toEntity(),
    );
  }
}

extension LocationMapper on LocationDto {
  LocationEntity toEntity() {
    return LocationEntity(
      lat: lat,
      long: long,
    );
  }
}
