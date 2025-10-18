import 'package:flowery_tracking/features/pickupLocation/data/models/status_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_status_history.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderStatusHistory {
  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) {
    // Accept both 'outfordelivery' and 'outForDelivery' from backend payloads
    final Map<String, dynamic> normalized = Map<String, dynamic>.from(json);
    if (normalized.containsKey('outfordelivery') &&
        !normalized.containsKey('outForDelivery')) {
      normalized['outForDelivery'] = normalized['outfordelivery'];
    }
    return _$OrderStatusHistoryFromJson(normalized);
  }

  const OrderStatusHistory({
    this.accepted,
    this.arrived,
    this.picked,
    this.outfordelivery,
    this.delivered,
  });
  @JsonKey(name: 'accepted')
  final StatusModel? accepted;

  @JsonKey(name: 'arrived')
  final StatusModel? arrived;

  @JsonKey(name: 'picked')
  final StatusModel? picked;

  @JsonKey(name: 'outForDelivery')
  final StatusModel? outfordelivery;

  @JsonKey(name: 'delivered')
  final StatusModel? delivered;

  Map<String, dynamic> toJson() => _$OrderStatusHistoryToJson(this);
}
