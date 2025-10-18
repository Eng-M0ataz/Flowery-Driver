import 'package:flowery_tracking/features/pickupLocation/data/models/driver_model.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/order_status_history.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/store_model.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_details_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailsRequestModel {
  const OrderDetailsRequestModel({
    this.statusHistory,
    this.driver,
    this.user,
    this.store,
  });

  factory OrderDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsRequestModelFromJson(json);

  @JsonKey(name: 'statusHistory')
  final OrderStatusHistory? statusHistory;

  @JsonKey(name: 'driver')
  final DriverModel? driver;

  @JsonKey(name: 'user')
  final UserModel? user;

  @JsonKey(name: 'store')
  final StoreModel? store;

  Map<String, dynamic> toJson() => _$OrderDetailsRequestModelToJson(this);
}

