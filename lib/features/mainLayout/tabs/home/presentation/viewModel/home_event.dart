import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';

sealed class HomeEvent {}

class LoadInitialOrdersEvent extends HomeEvent {}

class LoadNextOrdersEvent extends HomeEvent {}

class RefreshOrdersEvent extends HomeEvent {}

class RejectOrderEvent extends HomeEvent {
  RejectOrderEvent(this.orderId);

  final String orderId;
}

class StartOrderEvent extends HomeEvent {
  StartOrderEvent({required this.orderId});

  final String orderId;
}

class GetDriverDataEvent extends HomeEvent {}

class CreateOrderEvent extends HomeEvent {
  CreateOrderEvent({
    required this.path,
    required this.orderDetailsRequestModel,
  });

  final String path;
  final OrderDetailsRequestModel orderDetailsRequestModel;
}
