import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/store_entity.dart';

class AllOrdersEntity {
  AllOrdersEntity ({
    required this.id,
    required this.driver,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
  });

  final String id;
  final String driver;
  final OrderEntity order;
  final String createdAt;
  final String updatedAt;
  final StoreEntity store;
}