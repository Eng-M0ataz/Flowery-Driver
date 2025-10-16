import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_dto.g.dart';

@JsonSerializable()
class ResetPasswordResponseDto {
  ResetPasswordResponseDto({this.message, this.token});

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'token')
  final String? token;

  Map<String, dynamic> toJson() {
    return _$ResetPasswordResponseDtoToJson(this);
  }
}
