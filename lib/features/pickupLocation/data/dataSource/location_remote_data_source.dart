import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/responses/route_response_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract interface class LocationRemoteDataSource{
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  });

  Future <ApiResult<LocationResponseEntity>> getLocationsFromServer({
    required String path,
  });

  Future<RouteResponseModel> getRoute({
      required LatLng origin,
      required LatLng destination,
  });
}