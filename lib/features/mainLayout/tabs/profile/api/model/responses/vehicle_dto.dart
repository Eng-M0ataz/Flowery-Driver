import 'package:json_annotation/json_annotation.dart';

part 'vehicle_dto.g.dart';

@JsonSerializable()
class VehicleDto {

  VehicleDto ({
    this.Id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) {
    return _$VehicleDtoFromJson(json);
  }
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  Map<String, dynamic> toJson() {
    return _$VehicleDtoToJson(this);
  }
}