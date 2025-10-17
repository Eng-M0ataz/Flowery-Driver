import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/pickupLocation/api/mapper/response/location_response_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/responses/location_response_dto.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/responses/route_response_model.dart';
import 'package:flowery_tracking/features/pickupLocation/data/dataSource/location_remote_data_source.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  LocationRemoteDataSourceImpl(
      @Named(AppConstants.firebaseRealTimeDatabase) this._realTimeDataBaseService,
      @Named(AppConstants.firebaseRemoteExecutor) this._firebaseRemoteExecutor,
      this._dio,
      );
  late final RealTimeDataBaseService _realTimeDataBaseService;
  final FirebaseRemoteExecutor _firebaseRemoteExecutor;
  final Dio _dio;

  @override
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  }) async {
    final data = locationRequestModel.toJson();
    return _firebaseRemoteExecutor.execute<void, void>(
      request: () => _realTimeDataBaseService.update(path, data),
    );
  }

  @override
  Future<RouteResponseModel> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url =
        ApiConstants.computeRouteUrl; // New Routes API endpoint

    final data = {
      "origin": {
        "location": {"latLng": {"latitude": origin.latitude, "longitude": origin.longitude}}
      },
      "destination": {
        "location": {"latLng": {"latitude": destination.latitude, "longitude": destination.longitude}}
      },
      "travelMode": "TWO_WHEELER",
      "routingPreference": "TRAFFIC_AWARE",
      "polylineQuality": "HIGH_QUALITY",
      "polylineEncoding": "ENCODED_POLYLINE"
    };

    final response = await _dio.post(
      url,
      data: jsonEncode(data),
      options: Options(headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": ApiConstants.googleApiKey, // your key
        "X-Goog-FieldMask": "routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline"
      }),
    );

    return RouteResponseModel.fromJson(response.data);
  }

  @override
  Future<ApiResult<LocationResponseEntity>> getLocationsFromServer({
    required String path,
  }) async {
    return await _firebaseRemoteExecutor.execute<LocationResponseDto, LocationResponseEntity>(
      request: () async => await _realTimeDataBaseService.read(path),
      mapper: (dto) => dto.toEntity(),
    );
  }
}