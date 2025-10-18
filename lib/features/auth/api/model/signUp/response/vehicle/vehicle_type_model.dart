import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type_model.g.dart';

@JsonSerializable()
class VehicleTypeModel {
  VehicleTypeModel({
    required this.id,
    required this.type,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypeModelFromJson(json);
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => _$VehicleTypeModelToJson(this);
}
