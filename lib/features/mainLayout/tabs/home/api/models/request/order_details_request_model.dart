
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/driver_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_status_history.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/store_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_details_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailsRequestModel {
  const OrderDetailsRequestModel({
    required this.statusHistory,
    required this.driver,
    required this.user,
    required this.store,
  });

  factory OrderDetailsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsRequestModelFromJson(json);

  @JsonKey(name: 'statusHistory')
  final OrderStatusHistory statusHistory;

  @JsonKey(name: 'driver')
  final DriverModel driver;

  @JsonKey(name: 'user')
  final UserModel user;

  @JsonKey(name: 'store')
  final StoreModel store;

  Map<String, dynamic> toJson() => _$OrderDetailsRequestModelToJson(this);
}