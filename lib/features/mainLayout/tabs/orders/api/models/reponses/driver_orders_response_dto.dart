import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/all_orders_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/meta_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_orders_response_dto.g.dart';

@JsonSerializable()
class DriverOrdersResponseDto {

  DriverOrdersResponseDto ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory DriverOrdersResponseDto.fromJson(Map<String, dynamic> json) {
    return _$DriverOrdersResponseDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final MetaDataDto? metadata;
  @JsonKey(name: 'orders')
  final List<AllOrdersDto>? orders;

  Map<String, dynamic> toJson() {
    return _$DriverOrdersResponseDtoToJson(this);
  }
}












