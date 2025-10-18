import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_driver_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_dto.g.dart';

@JsonSerializable()
class EditProfileResponseDto {

  EditProfileResponseDto ({
    this.message,
    this.driver,
  });

  factory EditProfileResponseDto.fromJson(Map<String, dynamic> json) {
    return _$EditProfileResponseDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'driver')
  final EditDriverDto? driver;

  Map<String, dynamic> toJson() {
    return _$EditProfileResponseDtoToJson(this);
  }
}




