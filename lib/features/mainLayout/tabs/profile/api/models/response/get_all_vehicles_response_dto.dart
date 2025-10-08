import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/meta_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/vehicle_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_vehicles_response_dto.g.dart';

@JsonSerializable()
class GetAllVehiclesResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaDataDto? metadata;
  @JsonKey(name: "vehicles")
  final List<VehicleDto>? vehicles;

  GetAllVehiclesResponseDto ({
    this.message,
    this.metadata,
    this.vehicles,
  });

  factory GetAllVehiclesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$GetAllVehiclesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllVehiclesResponseDtoToJson(this);
  }
}