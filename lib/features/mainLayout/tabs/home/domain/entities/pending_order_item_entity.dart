import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_product_entity.dart';

class PendingOrderItemEntity {
  const PendingOrderItemEntity({
    this.productList,
    this.price,
    this.quantity,
    this.id,
  });

  final List<PendingProductEntity>?productList;
  final int? price;
  final int? quantity;
  final String? id;
}
