import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/store_entity.dart';

class AllOrdersEntity {
  AllOrdersEntity ({
    this.Id,
    this.driver,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  final String? Id;
  final String? driver;
  final OrderEntity? order;
  final String? createdAt;
  final String? updatedAt;
  final StoreEntity? store;
}