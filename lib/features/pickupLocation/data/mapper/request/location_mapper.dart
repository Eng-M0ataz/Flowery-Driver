import 'package:flowery_tracking/features/pickupLocation/data/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/location_entity.dart';

extension LocationMapper on LocationRequestModel {
  LocationEntity toEntity() {
    return LocationEntity(
      lat: lat,
      long: long,
    );
  }
}

extension LocationRequestMapper on LocationEntity {
  LocationRequestModel toModel() {
    return LocationRequestModel(
      lat: lat ?? 0.0,
      long: long ?? 0.0,
    );
  }
}
