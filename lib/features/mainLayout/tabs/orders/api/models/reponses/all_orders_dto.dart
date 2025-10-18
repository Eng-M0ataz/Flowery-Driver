import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/store_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_orders_dto.g.dart';

@JsonSerializable()
class AllOrdersDto {

  factory AllOrdersDto.fromJson(Map<String, dynamic> json) {
    return _$AllOrdersDtoFromJson(json);
  }

  AllOrdersDto ({
    this.id,
    this.driver,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.store,
  });
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'driver')
  final String? driver;
  @JsonKey(name: 'order')
  final OrderDto? order;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'store')
  final StoreDto? store;

  Map<String, dynamic> toJson() {
    return _$AllOrdersDtoToJson(this);
  }
}