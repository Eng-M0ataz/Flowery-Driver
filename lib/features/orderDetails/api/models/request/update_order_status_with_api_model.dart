import 'package:json_annotation/json_annotation.dart';

part 'update_order_status_with_api_model.g.dart';

@JsonSerializable()
class UpdateOrderStatusWithApiModel {
  const UpdateOrderStatusWithApiModel({required this.state});

  factory UpdateOrderStatusWithApiModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStatusWithApiModelFromJson(json);
  @JsonKey(name: 'state')
  final String state;
  Map<String, dynamic> toJson() => _$UpdateOrderStatusWithApiModelToJson(this);
}
