
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_status_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderStatusHistory {

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryFromJson(json);

  const OrderStatusHistory({
    this.accepted,
    this.arrived,
    this.picked,
    this.outForDelivery,
    this.delivered,
  });
  @JsonKey(name: 'accepted')
  final StatusModel? accepted;

  @JsonKey(name: 'arrived')
  final StatusModel? arrived;

  @JsonKey(name: 'picked')
  final StatusModel? picked;

  @JsonKey(name: 'outForDelivery')
  final StatusModel? outForDelivery;

  @JsonKey(name: 'delivered')
  final StatusModel? delivered;

  Map<String, dynamic> toJson() => _$OrderStatusHistoryToJson(this);
}