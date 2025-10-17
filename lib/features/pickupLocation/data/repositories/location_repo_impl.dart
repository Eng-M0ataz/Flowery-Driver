import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/data/dataSource/location_remote_data_source.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/route_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

@Injectable(as: LocationRepo)
class LocationRepoImpl implements LocationRepo {

  LocationRepoImpl(this._remoteDataSource);
  final LocationRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  }) {
    return _remoteDataSource.updateDriverLocationOnServer(
      locationRequestModel: locationRequestModel,
      path: path,
    );
  }

  @override
  Future<RouteEntity> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final result = await _remoteDataSource.getRoute(
      origin: origin,
      destination: destination,
    );

    final encoded = result.routes?.first.polyline?.encodedPolyline ?? '';
    final polylinePoints = PolylinePoints.decodePolyline(encoded);
    final polyPoints = polylinePoints
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList();

    return RouteEntity(
      polylinePoints: polyPoints,
      distanceMeters: result.routes?.first.distanceMeters?.value ?? 0,
      durationSeconds: result.routes?.first.duration?.value ?? 0,
    );
  }

  @override
  Future<ApiResult<LocationResponseEntity>> getLocationsFromServer({required String path}) {
    return _remoteDataSource.getLocationsFromServer(path: path);
  }
}