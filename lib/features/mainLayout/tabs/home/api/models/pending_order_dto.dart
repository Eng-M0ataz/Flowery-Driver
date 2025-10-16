import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_order_item_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_store_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_user_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/shipping_address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_order_dto.g.dart';

@JsonSerializable()
class PendingOrderDto {
  factory PendingOrderDto.fromJson(Map<String, dynamic> json) {
    return _$PendingOrderDtoFromJson(json);
  }

  PendingOrderDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
    this.shippingAddress,
  });

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final PendingUserDto? user;

  @JsonKey(name: 'orderItems')
  final List<PendingOrderItemDto>? orderItems;

  @JsonKey(name: 'totalPrice')
  final int? totalPrice;

  @JsonKey(name: 'paymentType')
  final String? paymentType;

  @JsonKey(name: 'isPaid')
  final bool? isPaid;

  @JsonKey(name: 'isDelivered')
  final bool? isDelivered;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'orderNumber')
  final String? orderNumber;

  @JsonKey(name: '__v')
  final int? v;

  @JsonKey(name: 'store')
  final PendingStoreDto? store;

  @JsonKey(name: 'shippingAddress')
  final ShippingAddressDto? shippingAddress;

  Map<String, dynamic> toJson() {
    return _$PendingOrderDtoToJson(this);
  }
}
