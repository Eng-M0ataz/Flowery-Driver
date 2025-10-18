import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState {
  LocationState({
    this.isListening = false,
    this.failure,
    this.entity,
    this.selectedCardIndex,
    this.deliveryLocations = const [],
  });

  final bool isListening;
  final Failure? failure;
  final OrderDetailsEntity? entity;
  final int? selectedCardIndex;
  final List<DeliveryLocation> deliveryLocations;

  LocationState copyWith({
    bool? isListening,
    Failure? failure,
    OrderDetailsEntity? entity,
    int? selectedCardIndex,
    List<DeliveryLocation>? deliveryLocations,
  }) {
    return LocationState(
      isListening: isListening ?? this.isListening,
      failure: failure ?? this.failure,
      entity: entity ?? this.entity,
      selectedCardIndex: selectedCardIndex ?? this.selectedCardIndex,
      deliveryLocations: deliveryLocations ?? this.deliveryLocations,
    );
  }
}
