// delivery_map_event.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DeliveryMapEvent {}

/// Initialize the map and load locations from Firebase
class InitializeMapEvent extends DeliveryMapEvent {
  final String orderId;
  InitializeMapEvent(this.orderId);
}

/// Called when Google Map is created
class MapCreatedEvent extends DeliveryMapEvent {
  final GoogleMapController controller;
  MapCreatedEvent(this.controller);
}

/// Update driver's current position from GPS
class UpdateDriverPositionEvent extends DeliveryMapEvent {
  final double latitude;
  final double longitude;
  final double? heading;

  UpdateDriverPositionEvent({
    required this.latitude,
    required this.longitude,
    this.heading,
  });
}

/// Select a delivery location card (store or user)
class SelectLocationCardEvent extends DeliveryMapEvent {
  final int locationIndex;
  SelectLocationCardEvent(this.locationIndex);
}

/// Deselect current card and clear route
class DeselectLocationCardEvent extends DeliveryMapEvent {}

/// Make a phone call
class MakePhoneCallEvent extends DeliveryMapEvent {
  final String phoneNumber;
  MakePhoneCallEvent(this.phoneNumber);
}

/// Open WhatsApp chat
class OpenWhatsAppEvent extends DeliveryMapEvent {
  final String phoneNumber;
  final String message;

  OpenWhatsAppEvent({
    required this.phoneNumber,
    this.message = '',
  });
}

/// Animate camera to specific location
class AnimateCameraToLocationEvent extends DeliveryMapEvent {
  final LatLng location;
  final double zoom;

  AnimateCameraToLocationEvent({
    required this.location,
    this.zoom = 15.0,
  });
}

/// Animate camera to show full route
class AnimateCameraToRouteEvent extends DeliveryMapEvent {
  final List<LatLng> routePoints;
  AnimateCameraToRouteEvent(this.routePoints);
}

/// Refresh locations from Firebase
class RefreshLocationsEvent extends DeliveryMapEvent {
  final String orderId;
  RefreshLocationsEvent(this.orderId);
}

/// Dispose resources
class DisposeMapEvent extends DeliveryMapEvent {}