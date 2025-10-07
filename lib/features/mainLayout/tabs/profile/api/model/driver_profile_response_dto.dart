import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/driver_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_profile_response_dto.g.dart';

@JsonSerializable()
class DriverProfileResponseDto {

  DriverProfileResponseDto ({
    this.message,
    this.driver,
  });

  factory DriverProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return _$DriverProfileResponseDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'driver')
  final DriverDto? driver;

  Map<String, dynamic> toJson() {
    return _$DriverProfileResponseDtoToJson(this);
  }
}



