import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteEntity {
  final List<LatLng> polylinePoints;
  final double distanceMeters;
  final double durationSeconds;

  const RouteEntity({
    required this.polylinePoints,
    required this.distanceMeters,
    required this.durationSeconds,
  });
}