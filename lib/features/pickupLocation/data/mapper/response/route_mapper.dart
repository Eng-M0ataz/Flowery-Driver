import 'package:flowery_tracking/features/pickupLocation/data/models/responses/route_response_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/route_entity.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension RouteMapper on RouteResponseModel {
  RouteEntity toEntity() {
    final encoded = routes?.first.polyline?.encodedPolyline ?? '';
    final polylinePoints = PolylinePoints.decodePolyline(encoded);
    final polyPoints = polylinePoints
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList();

    return RouteEntity(
      polylinePoints: polyPoints,
      distanceMeters: routes?.first.distanceMeters?.value ?? 0,
      durationSeconds: routes?.first.duration?.value ?? 0,
    );
  }
}
