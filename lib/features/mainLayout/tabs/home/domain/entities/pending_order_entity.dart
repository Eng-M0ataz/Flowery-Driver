import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_store_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_user_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/shipping_address_entity.dart';

class PendingOrderEntity {
  PendingOrderEntity({
    this.id,
    this.store,
    this.user,
    this.totalPrice,
    this.shippingAddress,
  });

  final String? id;
  final PendingStoreEntity? store;
  final PendingUserEntity? user;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
}
