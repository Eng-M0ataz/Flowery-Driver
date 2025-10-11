import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_dto.g.dart';

@JsonSerializable()
class OrderItemsDto {

  OrderItemsDto ({
    this.product,
    this.price,
    this.quantity,
    this.Id,
  });

  factory OrderItemsDto.fromJson(Map<String, dynamic> json) {
    return _$OrderItemsDtoFromJson(json);
  }
  @JsonKey(name: 'product')
  final ProductDto? product;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: '_id')
  final String? Id;

  Map<String, dynamic> toJson() {
    return _$OrderItemsDtoToJson(this);
  }
}