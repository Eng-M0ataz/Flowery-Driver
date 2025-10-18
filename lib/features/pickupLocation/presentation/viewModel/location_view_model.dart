// location_view_model.dart
import 'dart:async';

import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/useCases/get_locations_use_case.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_event.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_state.dart';
import 'package:flowery_tracking/features/trackMap/domain/useCases/get_route_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationViewModel extends Bloc<LocationEvent, LocationState> {
  LocationViewModel(
      this._trackOrderUseCase,
      this._getRouteUseCase
      ) : super(LocationState());

  final GetLocationsUseCase _trackOrderUseCase;
  final GetRouteUseCase _getRouteUseCase;
  StreamSubscription<OrderDetailsEntity>? _orderSubscription;

  Future<void> doIntend(LocationEvent event) async {
    switch (event) {
      case StartListeningOrderEvent():
        _startListening(event.path);
        break;
      case StopListeningOrderEvent():
        _stopListening();
        break;
      case SelectCardEvent():
        _selectCard(event.cardIndex);
        break;
    }
  }

  void _startListening(String path) {
    emit(state.copyWith(isListening: true));

    _orderSubscription = _trackOrderUseCase
        .listenData(path)
        .listen(
          (entity) {
            final deliveryLocations = _convertToDeliveryLocations(entity);
            emit(
              state.copyWith(
                entity: entity,
                isListening: true,
                deliveryLocations: deliveryLocations,
              ),
            );
          },
          onError: (error) {
            emit(
              state.copyWith(
                isListening: false,
                failure: Failure(errorMessage: error.toString()),
              ),
            );
          },
        );
  }

  void _stopListening() {
    _orderSubscription?.cancel();
    emit(state.copyWith(isListening: false));
  }

  void _selectCard(int cardIndex) {
    emit(state.copyWith(selectedCardIndex: cardIndex));
  }

  List<DeliveryLocation> _convertToDeliveryLocations(
    OrderDetailsEntity entity,
  ) {
    final List<DeliveryLocation> locations = [];

    // Add store location
    if (entity.store != null) {
      locations.add(
        DeliveryLocation(
          title: 'Flowery store',
          address:
              '20th st, Sheikh Zayed, Giza', // Default address - you can get this from store entity if available
          phoneNumber:
              '+201010700887', // Default phone - you can get this from store entity if available
          imageUrl: 'https://flower.elevateegy.com/uploads/default-profile.png',
          location: entity.store!.storeLocation,
          isStore: true,
        ),
      );
    }

    // Add user location
    if (entity.user != null) {
      locations.add(
        DeliveryLocation(
          title:
              'Nour mohamed', // Default name - you can get this from user entity if available
          address:
              '20th st, Sheikh Zayed, Giza', // Default address - you can get this from user entity if available
          phoneNumber:
              '+201010700887', // Default phone - you can get this from user entity if available
          imageUrl: 'https://flower.elevateegy.com/uploads/default-profile.png',
          location: entity.user!.userLocation,
          isStore: false,
        ),
      );
    }
    return locations;
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
