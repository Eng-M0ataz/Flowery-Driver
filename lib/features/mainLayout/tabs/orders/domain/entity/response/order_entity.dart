import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_items_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/user_entity.dart';

class OrderEntity {
  OrderEntity ({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
  });

  final String id;
  final UserEntity user;
  final List<OrderItemsEntity> orderItems;
  final int totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;
}