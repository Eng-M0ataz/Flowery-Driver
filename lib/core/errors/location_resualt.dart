import 'package:flowery_tracking/core/enum/location_return_types.dart';

sealed class LocationResult<T> {}

class LocationSuccess<T> extends LocationResult<T> {
  LocationSuccess({required this.data});
  final T data;
}

class LocationError<T> extends LocationResult<T> {
  LocationError({required this.error});
  final LocationReturnTypes error;
}