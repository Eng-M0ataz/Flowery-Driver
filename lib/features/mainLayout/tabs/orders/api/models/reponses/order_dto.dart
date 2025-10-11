import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_items_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {


  OrderDto ({
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
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return _$OrderDtoFromJson(json);
  }
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'user')
  final UserDto? user;
  @JsonKey(name: 'orderItems')
  final List<OrderItemsDto>? orderItems;
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

  Map<String, dynamic> toJson() {
    return _$OrderDtoToJson(this);
  }
}