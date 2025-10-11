import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_entity.dart';

class OrderItemsEntity {
  OrderItemsEntity ({
    this.product,
    this.price,
    this.quantity,
    this.Id,
  });

  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? Id;
}