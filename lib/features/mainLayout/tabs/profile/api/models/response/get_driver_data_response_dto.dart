import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/driver_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_driver_data_response_dto.g.dart';

@JsonSerializable()
class GetDriverDataResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "driver")
  final DriverDataDto? driver;

  GetDriverDataResponseDto ({
    this.message,
    this.driver,
  });

  factory GetDriverDataResponseDto.fromJson(Map<String, dynamic> json) {
    return _$GetDriverDataResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetDriverDataResponseDtoToJson(this);
  }
}
