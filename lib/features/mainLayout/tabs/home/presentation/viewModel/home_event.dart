import 'package:flowery_tracking/core/models/order_details_model.dart';

sealed class HomeEvent {}

class LoadInitialOrdersEvent extends HomeEvent {}

class LoadNextOrdersEvent extends HomeEvent {}

class RefreshOrdersEvent extends HomeEvent {}

class NavigateToOrderDetailsUiEvent extends HomeEvent {
  NavigateToOrderDetailsUiEvent(this.args);

  final OrderDetailsModel args;
}

class RejectOrderEvent extends HomeEvent {
  RejectOrderEvent(this.orderId);

  final String orderId;
}
class UpdateOrderStateEvent extends HomeEvent {
  UpdateOrderStateEvent({
    required this.orderId,
    required this.state,
  });

  final String orderId;
  final String state;
}