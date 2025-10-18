import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_entity.dart';

class OrderItemsEntity {
  OrderItemsEntity ({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  final ProductEntity product;
  final int price;
  final int quantity;
  final String id;
}