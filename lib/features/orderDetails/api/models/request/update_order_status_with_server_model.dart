import 'package:json_annotation/json_annotation.dart';

part 'update_order_status_with_server_model.g.dart';

@JsonSerializable()
class UpdateOrderStatusWithServerModel {
  const UpdateOrderStatusWithServerModel({
    required this.status,
    required this.statusUpdatedDate,
  });

  factory UpdateOrderStatusWithServerModel.fromJson(
    Map<String, dynamic> json,
  ) => _$UpdateOrderStatusWithServerModelFromJson(json);
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'statusUpdateDate')
  final String statusUpdatedDate;
  Map<String, dynamic> toJson() =>
      _$UpdateOrderStatusWithServerModelToJson(this);
}
