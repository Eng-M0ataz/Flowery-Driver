// delivery_map_state.dart
import 'package:flowery_tracking/features/pickupLocation/domain/entities/route_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMapState {
  // Loading states
  final bool isInitializing;
  final bool isLoadingRoute;
  final bool isUpdatingLocation;

  // Location data
  final LatLng? driverLocation;
  final double? driverHeading;
  final LatLng? storeLocation;
  final LatLng? userLocation;

  // Map display data
  final Set<Marker> markers;
  final Set<Polyline> polylines;

  // Selection state (0 = store, 1 = user, null = none)
  final int? selectedCardIndex;

  // Route data
  final RouteEntity? currentRoute;

  // Error handling
  final String? errorMessage;

  // Initialization flag
  final bool isInitialized;

  const DeliveryMapState({
    this.isInitializing = true,
    this.isLoadingRoute = false,
    this.isUpdatingLocation = false,
    this.driverLocation,
    this.driverHeading,
    this.storeLocation,
    this.userLocation,
    this.markers = const {},
    this.polylines = const {},
    this.selectedCardIndex,
    this.currentRoute,
    this.errorMessage,
    this.isInitialized = false,
  });

  // Convenience getters
  bool get hasRoute => currentRoute != null;
  bool get hasStoreSelected => selectedCardIndex == 0;
  bool get hasUserSelected => selectedCardIndex == 1;
  bool get hasSelection => selectedCardIndex != null;
  bool get isLoading => isInitializing || isLoadingRoute || isUpdatingLocation;

  DeliveryMapState copyWith({
    bool? isInitializing,
    bool? isLoadingRoute,
    bool? isUpdatingLocation,
    LatLng? driverLocation,
    double? driverHeading,
    LatLng? storeLocation,
    LatLng? userLocation,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    int? selectedCardIndex,
    RouteEntity? currentRoute,
    String? errorMessage,
    bool? isInitialized,
    bool clearSelection = false,
    bool clearRoute = false,
    bool clearError = false,
  }) {
    return DeliveryMapState(
      isInitializing: isInitializing ?? this.isInitializing,
      isLoadingRoute: isLoadingRoute ?? this.isLoadingRoute,
      isUpdatingLocation: isUpdatingLocation ?? this.isUpdatingLocation,
      driverLocation: driverLocation ?? this.driverLocation,
      driverHeading: driverHeading ?? this.driverHeading,
      storeLocation: storeLocation ?? this.storeLocation,
      userLocation: userLocation ?? this.userLocation,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      selectedCardIndex: clearSelection ? null : (selectedCardIndex ?? this.selectedCardIndex),
      currentRoute: clearRoute ? null : (currentRoute ?? this.currentRoute),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  String toString() {
    return 'DeliveryMapState(isInitializing: $isInitializing, isLoadingRoute: $isLoadingRoute, '
        'driverLocation: $driverLocation, selectedIndex: $selectedCardIndex, '
        'hasRoute: $hasRoute, isInitialized: $isInitialized)';
  }
}