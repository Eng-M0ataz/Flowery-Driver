import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_item_entity.dart';
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
    this.state,
    this.paymentType,
    this.orderItems,
  });

  final String? id;
  final PendingStoreEntity? store;
  final PendingUserEntity? user;
  final int? totalPrice;
  final ShippingAddressEntity? shippingAddress;
  final String? state;
  final String? paymentType;
  final List<PendingOrderItemEntity>? orderItems;

  PendingOrderEntity copyWith({
    String? id,
    PendingStoreEntity? store,
    PendingUserEntity? user,
    int? totalPrice,
    ShippingAddressEntity? shippingAddress,
    String? state,
  }) {
    return PendingOrderEntity(
      id: id ?? this.id,
      store: store ?? this.store,
      user: user ?? this.user,
      totalPrice: totalPrice ?? this.totalPrice,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      state: state ?? this.state,
    );
  }
}

