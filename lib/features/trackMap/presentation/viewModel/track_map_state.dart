import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';

class TrackMapState {

  const TrackMapState({
    this.isLoading = false,
    this.routeResponse,
    this.failure,
  });
  final bool isLoading;
  final RouteResponseEntity? routeResponse;
  final Failure? failure;

  TrackMapState copyWith({
    bool? isLoading,
    RouteResponseEntity? routeResponse,
    Failure? failure,
  }) {
    return TrackMapState(
      isLoading: isLoading ?? this.isLoading,
      routeResponse: routeResponse ?? this.routeResponse,
      failure: failure ?? this.failure,
    );
  }
}