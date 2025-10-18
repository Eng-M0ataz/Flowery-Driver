import 'dart:async';

import 'package:flowery_tracking/core/enum/location_return_types.dart';
import 'package:flowery_tracking/core/errors/location_resualt.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<LocationResult<Position>> determinePosition() async {
    final bool serviceEnabled = await islocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationError<Position>(
        error: LocationReturnTypes.locationServiceDisabled,
      );
    }

    final LocationReturnTypes permissionResult =
        await checkAndRequestPermission();
    if (permissionResult == LocationReturnTypes.locationPermissionGranted) {
      try {
        final Position position = await Geolocator.getCurrentPosition();
        return LocationSuccess<Position>(data: position);
      } catch (e) {
        return LocationError<Position>(
          error: LocationReturnTypes.failedToGetLocation,
        );
      }
    } else {
      return LocationError<Position>(error: permissionResult);
    }
  }

  static Future<LocationReturnTypes> checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationReturnTypes.locationPermissionDenied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationReturnTypes.locationPermissionDeniedForever;
    }
    return LocationReturnTypes.locationPermissionGranted;
  }

  static Future<bool> islocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  static Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  static StreamSubscription<Position> locationStream({
    required void Function(Position position) onData,
    required void Function(Object error) onError,
  }) {
    final positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    ).listen(onData, onError: onError);

    return positionStream;
  }
}
