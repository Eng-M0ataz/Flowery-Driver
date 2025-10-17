import 'package:flowery_tracking/features/pickupLocation/domain/entities/route_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetRouteUseCase {
  GetRouteUseCase(this._repo);
  final LocationRepo _repo;

  Future<RouteEntity> call({
    required LatLng origin,
    required LatLng destination,
  }) {
    return _repo.getRoute(origin: origin, destination: destination);
  }
}
