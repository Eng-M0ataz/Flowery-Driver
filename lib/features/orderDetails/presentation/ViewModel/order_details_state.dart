import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/errors/failure.dart';

class OrderDetailsState extends Equatable {
  const OrderDetailsState({
    this.errorMessage,
    this.orderStatus,
    this.isLoading = false,
    this.driverServerStatusFailure,
    this.driverApiStatusFailure,
    this.updateDriverLocationFailure,
    this.deleteOrderFailure,
    this.LocationFailure,
  });

  final String? errorMessage;
  final OrderStatus? orderStatus;
  final bool? isLoading;
  final Failure? driverServerStatusFailure;
  final Failure? driverApiStatusFailure;
  final Failure? updateDriverLocationFailure;
  final Failure? deleteOrderFailure;
  final String? LocationFailure;

  OrderDetailsState copyWith({
    String? errorMessage,
    OrderStatus? orderStatus,
    bool? isLoading,
    Failure? driverServerStatusFailure,
    Failure? driverApiStatusFailure,
    Failure? updateDriverLocationFailure,
    Failure? deleteOrderFailure,
    String? LocationFailure,
  }) {
    return OrderDetailsState(
      errorMessage: errorMessage ?? this.errorMessage,
      orderStatus: orderStatus ?? this.orderStatus,
      isLoading: isLoading ?? this.isLoading,
      driverServerStatusFailure:
          driverServerStatusFailure ?? this.driverServerStatusFailure,
      driverApiStatusFailure:
          driverApiStatusFailure ?? this.driverApiStatusFailure,
      updateDriverLocationFailure:
          updateDriverLocationFailure ?? this.updateDriverLocationFailure,
      deleteOrderFailure: deleteOrderFailure ?? this.deleteOrderFailure,
      LocationFailure: LocationFailure ?? this.LocationFailure,
    );
  }

  @override
  List<Object?> get props => [
    errorMessage,
    orderStatus,
    isLoading,
    driverServerStatusFailure,
    driverApiStatusFailure,
    updateDriverLocationFailure,
    deleteOrderFailure,
    LocationFailure,
  ];
}
