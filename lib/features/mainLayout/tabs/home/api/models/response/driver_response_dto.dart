import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/driver_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_response_dto.g.dart';

@JsonSerializable()
class DriverResponseDto {
  DriverResponseDto({this.message, this.driver});

  factory DriverResponseDto.fromJson(Map<String, dynamic> json) {
    return _$DriverResponseDtoFromJson(json);
  }
  String? message;
  DriverDto? driver;

  Map<String, dynamic> toJson() => _$DriverResponseDtoToJson(this);
}
