import 'dart:async';

import 'package:flowery_tracking/core/enum/location_return_types.dart';
import 'package:flowery_tracking/core/errors/location_resualt.dart';
import 'package:flowery_tracking/core/services/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

class _FakeGeolocator extends GeolocatorPlatform {
  _FakeGeolocator({
    required this.serviceEnabled,
    required this.checkPermissionResult,
    required this.requestPermissionResult,
    required this.currentPosition,
    // ignore: unused_element_parameter
    this.throwOnGetCurrent = false,
    // ignore: unused_element_parameter
    this.openAppSettingsResult = true,
    // ignore: unused_element_parameter
    this.openLocationSettingsResult = true,
  });

  bool serviceEnabled;
  LocationPermission checkPermissionResult;
  LocationPermission requestPermissionResult;
  Position currentPosition;
  bool throwOnGetCurrent;
  bool openAppSettingsResult;
  bool openLocationSettingsResult;

  final StreamController<Position> _positionController =
      StreamController<Position>.broadcast();
  final StreamController<Object> _errorController =
      StreamController<Object>.broadcast();

  void addPosition(Position p) => _positionController.add(p);
  void addError(Object e) => _errorController.add(e);

  @override
  Future<bool> isLocationServiceEnabled() async => serviceEnabled;

  @override
  Future<LocationPermission> checkPermission() async => checkPermissionResult;

  @override
  Future<LocationPermission> requestPermission() async =>
      requestPermissionResult;

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    if (throwOnGetCurrent) {
      throw Exception('failed');
    }
    return currentPosition;
  }

  @override
  Future<bool> openAppSettings() async => openAppSettingsResult;

  @override
  Future<bool> openLocationSettings() async => openLocationSettingsResult;

  @override
  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    // Merge error into position stream by rethrowing asynchronously
    // Consumers pass onError to listen()
    return _positionController.stream;
  }
}

void main() {
  setUp(() {
    GeolocatorPlatform.instance = _FakeGeolocator(
      serviceEnabled: true,
      checkPermissionResult: LocationPermission.always,
      requestPermissionResult: LocationPermission.always,
      currentPosition: Position(
        latitude: 10,
        longitude: 20,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      ),
    );
  });

  test('determinePosition returns service disabled error', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.serviceEnabled = false;
    final result = await LocationService.determinePosition();
    expect(result, isA<LocationError<Position>>());
    final err = result as LocationError<Position>;
    expect(err.error, LocationReturnTypes.locationServiceDisabled);
  });

  test(
    'determinePosition returns permission denied flow when denied twice',
    () async {
      final fake = GeolocatorPlatform.instance as _FakeGeolocator;
      fake.serviceEnabled = true;
      fake.checkPermissionResult = LocationPermission.denied;
      fake.requestPermissionResult = LocationPermission.denied;
      final result = await LocationService.determinePosition();
      expect(result, isA<LocationError<Position>>());
      expect(
        (result as LocationError<Position>).error,
        LocationReturnTypes.locationPermissionDenied,
      );
    },
  );

  test('determinePosition returns deniedForever when so', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.checkPermissionResult = LocationPermission.deniedForever;
    final result = await LocationService.determinePosition();
    expect(result, isA<LocationError<Position>>());
    expect(
      (result as LocationError<Position>).error,
      LocationReturnTypes.locationPermissionDeniedForever,
    );
  });

  test(
    'determinePosition returns success when permitted and service enabled',
    () async {
      final result = await LocationService.determinePosition();
      expect(result, isA<LocationSuccess<Position>>());
      final pos = (result as LocationSuccess<Position>).data;
      expect(pos.latitude, 10);
      expect(pos.longitude, 20);
    },
  );

  test('determinePosition returns failedToGetLocation on exception', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.throwOnGetCurrent = true;
    final result = await LocationService.determinePosition();
    expect(result, isA<LocationError<Position>>());
    expect(
      (result as LocationError<Position>).error,
      LocationReturnTypes.failedToGetLocation,
    );
  });

  test(
    'checkAndRequestPermission returns granted when already granted',
    () async {
      final fake = GeolocatorPlatform.instance as _FakeGeolocator;
      fake.checkPermissionResult = LocationPermission.whileInUse;
      final res = await LocationService.checkAndRequestPermission();
      expect(res, LocationReturnTypes.locationPermissionGranted);
    },
  );

  test('checkAndRequestPermission handles denied then granted', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.checkPermissionResult = LocationPermission.denied;
    fake.requestPermissionResult = LocationPermission.whileInUse;
    final res = await LocationService.checkAndRequestPermission();
    expect(res, LocationReturnTypes.locationPermissionGranted);
  });

  test('islocationServiceEnabled proxies platform value', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.serviceEnabled = true;
    expect(await LocationService.islocationServiceEnabled(), true);
    fake.serviceEnabled = false;
    expect(await LocationService.islocationServiceEnabled(), false);
  });

  test('open settings methods proxy platform', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    fake.openAppSettingsResult = true;
    fake.openLocationSettingsResult = true;
    expect(await LocationService.openAppSettings(), true);
    expect(await LocationService.openLocationSettings(), true);
  });

  test('locationStream emits positions and handles errors', () async {
    final fake = GeolocatorPlatform.instance as _FakeGeolocator;
    final received = <Position>[];
    final errors = <Object>[];
    final sub = LocationService.locationStream(
      onData: received.add,
      onError: errors.add,
    );

    fake.addPosition(fake.currentPosition);
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(received.length, 1);

    // Cancel subscription to avoid leaks in test
    await sub.cancel();
  });
}
