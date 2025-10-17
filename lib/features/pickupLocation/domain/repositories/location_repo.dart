import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/route_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract interface class LocationRepo {
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  });

  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  });

  Future<ApiResult<LocationResponseEntity>> getLocationsFromServer({
    required String path
  });
}