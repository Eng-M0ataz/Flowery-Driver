import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_metadata_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_orders_response_dto.g.dart';

@JsonSerializable()
class PendingOrdersResponseDto {
  PendingOrdersResponseDto({this.message, this.metadata, this.orders});

  factory PendingOrdersResponseDto.fromJson(Map<String, dynamic> json) {
    return _$PendingOrdersResponseDtoFromJson(json);
  }

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final PendingMetadataDto? metadata;
  @JsonKey(name: 'orders')
  final List<PendingOrderDto>? orders;

  Map<String, dynamic> toJson() {
    return _$PendingOrdersResponseDtoToJson(this);
  }
}
