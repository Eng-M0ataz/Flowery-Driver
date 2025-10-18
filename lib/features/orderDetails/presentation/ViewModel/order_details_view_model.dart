import 'dart:async';

import 'package:flowery_tracking/core/enum/location_return_types.dart';
import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/services/location_service.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/delete_order_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_driver_location_on_server_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_on_server_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_with_api_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_events.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsViewModel extends Cubit<OrderDetailsState> {
  OrderDetailsViewModel(
    this._deleteOrderUseCase,
    this._updateDriverLocationOnServerUseCase,
    this._updateOrderStatusOnServerUseCase,
    this._updateOrderStatusWithApiUseCase,
  ) : super(const OrderDetailsState());

  final DeleteOrderUseCase _deleteOrderUseCase;
  final UpdateOrderStatusWithApiUseCase _updateOrderStatusWithApiUseCase;
  final UpdateOrderStatusOnServerUseCase _updateOrderStatusOnServerUseCase;
  final UpdateDriverLocationOnServerUseCase
  _updateDriverLocationOnServerUseCase;

  StreamSubscription<Position>? _streamSubscription;
  StreamSubscription<LocationReturnTypes>? ListenOnLocationPermission;

  Future<void> doIntent({required OrderDetailsEvents event}) async {
    switch (event) {
      case DeleteOrderEvent():
        break;
      case CheckLocationPermissionAndStreamDriverLocation(path: final path):
        _checkLocationPermissionAndStreamDriverLocation(path: path);
        break;
      case UpdateOrderStatusWithApiEvent(
        orderId: final orderId,
        updateOrderStatusWithApiModel: final updateOrderStatusWithApiModel,
      ):
        await _updateOrderStatusWithApi(
          orderId: orderId,
          UpdateOrderStatusWithApiModel: updateOrderStatusWithApiModel,
        );
      case UpdateOrderStatusOnServerEvent(
        path: final path,
        updateOrderStatusWithServerModel: final updateOrderStatusWithServerModel,
      ):
        await _updateOrderStatusOnServer(
          path: path,
          updateOrderStatusModel: updateOrderStatusWithServerModel,
        );
      case HandleOrderStatusFlowEvent(
        orderId: final orderId,
        path: final path,
        updateOrderStatusModel: final updateOrderStatusModel,
        updateOrderStatusWithApiModel: final updateOrderStatusWithApiModel,
        deletePath: final deletePath,
      ):
        await _handleOrderStatusFlow(
          deletePath: deletePath,
          path: path,
          orderId: orderId,
          updateOrderStatusModel: updateOrderStatusModel,
          updateOrderStatusWithApiModel: updateOrderStatusWithApiModel,
        );
    }
  }

  Future<void> _deleteOrder(String path) async {
    final result = await _deleteOrderUseCase.invoke(path: path);
    switch (result) {
      case ApiSuccessResult<void>():
        return;

      case ApiErrorResult<void>():
        emit(state.copyWith(deleteOrderFailure: result.failure));
    }
  }

  Future<void> _updateOrderStatusWithApi({
    required String orderId,
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  }) async {
    final result = await _updateOrderStatusWithApiUseCase.invoke(
      id: orderId,
      UpdateOrderStatusWithApiModel: UpdateOrderStatusWithApiModel,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        return;
      case ApiErrorResult<void>():
        emit(state.copyWith(driverApiStatusFailure: result.failure));
    }
  }

  Future<void> _updateDriverLocationOnServer({
    required String path,
    required LocationRequestModel locationRequestModel,
  }) async {
    final result = await _updateDriverLocationOnServerUseCase.invoke(
      path: path,
      locationRequestModel: locationRequestModel,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        return;
      case ApiErrorResult<void>():
        emit(state.copyWith(updateDriverLocationFailure: result.failure));
    }
  }

  Future<void> _updateOrderStatusOnServer({
    required String path,
    required UpdateOrderStatusWithServerModel updateOrderStatusModel,
  }) async {
    emit(state.copyWith(isLoading: true));
    final result = await _updateOrderStatusOnServerUseCase.invoke(
      path: path,
      updateOrderStatusModel: updateOrderStatusModel,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        final newStatus = OrderStatus.values.firstWhere(
          (e) => e.name == updateOrderStatusModel.status,
        );
        emit(state.copyWith(orderStatus: newStatus, isLoading: false));
      case ApiErrorResult<void>():
        emit(state.copyWith(driverServerStatusFailure: result.failure));
    }
  }

  void _checkLocationPermissionAndStreamDriverLocation({
    required String path,
  }) async {
    final result = await LocationService.checkAndRequestPermission();
    switch (result) {
      case LocationReturnTypes.locationServiceDisabled:
        emit(state.copyWith(errorMessage: result.name));
        break;
      case LocationReturnTypes.locationPermissionDenied:
        emit(state.copyWith(errorMessage: result.name));
        break;
      case LocationReturnTypes.locationPermissionDeniedForever:
        emit(state.copyWith(errorMessage: result.name));
        break;
      case LocationReturnTypes.locationPermissionGranted:
        _streamDriverLocation(path: path);
        break;
      case LocationReturnTypes.failedToGetLocation:
        emit(state.copyWith(errorMessage: result.name));
        break;
    }
  }

  void _streamDriverLocation({required String path}) {
    _streamSubscription = LocationService.locationStream(
      onData: (position) {
        _updateDriverLocationOnServer(
          path: path,
          locationRequestModel: LocationRequestModel(
            lat: position.latitude,
            long: position.longitude,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(LocationFailure: error.toString()));
      },
    );
  }

  void openLocationSettings() {
    LocationService.openLocationSettings();
  }

  void openAppSettings() {
    LocationService.openAppSettings();
  }

  void _stopTracking() {
    _streamSubscription!.cancel();
  }

  @override
  Future<void> close() {
    _stopTracking();
    return super.close();
  }

  Future<void> _handleOrderStatusFlow({
    required String path,
    required String deletePath,
    required String orderId,
    required UpdateOrderStatusWithServerModel updateOrderStatusModel,
    required UpdateOrderStatusWithApiModel updateOrderStatusWithApiModel,
  }) async {
    await _updateOrderStatusOnServer(
      path: path,
      updateOrderStatusModel: updateOrderStatusModel,
    );
    if (state.orderStatus == OrderStatus.delivered) {
      await _updateOrderStatusWithApi(
        orderId: orderId,
        UpdateOrderStatusWithApiModel: updateOrderStatusWithApiModel,
      );
      await _deleteOrder(deletePath);
    }
  }
}
