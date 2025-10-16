import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_order_item_dto.g.dart';

@JsonSerializable()
class PendingOrderItemDto {
  factory PendingOrderItemDto.fromJson(Map<String, dynamic> json) {
    return _$PendingOrderItemDtoFromJson(json);
  }

  PendingOrderItemDto({this.product, this.price, this.quantity, this.id});

  @JsonKey(name: 'product')
  final PendingProductDto? product;

  @JsonKey(name: 'price')
  final int? price;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: '_id')
  final String? id;

  Map<String, dynamic> toJson() {
    return _$PendingOrderItemDtoToJson(this);
  }
}
