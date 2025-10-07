import 'package:json_annotation/json_annotation.dart';

part 'update_order_state_response_dto.g.dart';

@JsonSerializable()
class UpdateOrderStateResponseDto {
  factory UpdateOrderStateResponseDto.fromJson(Map<String, dynamic> json) {
    return _$UpdateOrderStateResponseDtoFromJson(json);
  }

  UpdateOrderStateResponseDto({this.message, this.orders});

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'orders')
  final Orders? orders;

  Map<String, dynamic> toJson() {
    return _$UpdateOrderStateResponseDtoToJson(this);
  }
}

@JsonSerializable()
class Orders {
  Orders({
    this.Id,
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
    this.V,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return _$OrdersFromJson(json);
  }

  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'user')
  final String? user;
  @JsonKey(name: 'orderItems')
  final List<OrderItems>? orderItems;
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
  final int? V;

  Map<String, dynamic> toJson() {
    return _$OrdersToJson(this);
  }
}

@JsonSerializable()
class OrderItems {
  OrderItems({this.product, this.price, this.quantity, this.Id});

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsFromJson(json);
  }

  @JsonKey(name: 'product')
  final String? product;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? Id;

  Map<String, dynamic> toJson() {
    return _$OrderItemsToJson(this);
  }
}
