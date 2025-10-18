import 'package:flowery_tracking/features/pickupLocation/domain/entities/driver_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/order_status_history_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/store_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/user_entity.dart';

class OrderDetailsEntity {

  const OrderDetailsEntity({
    this.statusHistory,
    this.driver,
    this.user,
    this.store,
  });
  final OrderStatusHistoryEntity? statusHistory;
  final DriverEntity? driver;
  final UserEntity? user;
  final StoreEntity? store;
}
