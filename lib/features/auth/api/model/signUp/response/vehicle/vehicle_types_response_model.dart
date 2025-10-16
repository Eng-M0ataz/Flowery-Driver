import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_meta_data_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_type_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_types_response_model.g.dart';

@JsonSerializable()
class VehicleTypesResponseDto {
  const VehicleTypesResponseDto({
    required this.message,
    required this.metadata,
    required this.vehicles,
  });

  factory VehicleTypesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VehicleTypesResponseDtoFromJson(json);
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'metadata')
  final Metadata? metadata;
  @JsonKey(name: 'vehicles')
  final List<VehicleTypeModel>? vehicles;

  Map<String, dynamic> toJson() => _$VehicleTypesResponseDtoToJson(this);
}
