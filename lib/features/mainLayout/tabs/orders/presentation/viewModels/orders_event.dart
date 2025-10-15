sealed class OrdersEvent {}

class GetDriverOrdersEvent extends OrdersEvent{}
class GetProductEvent extends OrdersEvent{
  GetProductEvent(this.productId);
  final String productId;
}

