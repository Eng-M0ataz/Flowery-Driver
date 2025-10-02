import 'package:flowery_tracking/core/models/order_details_args.dart';

sealed class HomeEvent {}

class LoadInitialOrdersEvent extends HomeEvent {}

class LoadNextOrdersEvent extends HomeEvent {}

class RefreshOrdersEvent extends HomeEvent {}

class NavigateToOrderDetailsUiEvent extends HomeEvent {
  NavigateToOrderDetailsUiEvent(this.args);

  final OrderDetailsArgs args;
}

class RejectOrderEvent extends HomeEvent {
  RejectOrderEvent(this.orderId);

  final String orderId;
}
