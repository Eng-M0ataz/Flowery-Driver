import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_response_dto.g.dart';

@JsonSerializable()
class VehicleResponseDto {

  VehicleResponseDto ({
    this.message,
    this.vehicle,
  });

  factory VehicleResponseDto.fromJson(Map<String, dynamic> json) {
    return _$VehicleResponseDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'vehicle')
  final VehicleDto? vehicle;

  Map<String, dynamic> toJson() {
    return _$VehicleResponseDtoToJson(this);
  }
}




