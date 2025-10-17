import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_dto.g.dart';

@JsonSerializable()
class ResetPasswordResponseDto {
  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseDtoFromJson(json);

  ResetPasswordResponseDto({this.message, this.token});
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'token')
  final String? token;

  Map<String, dynamic> toJson() => _$ResetPasswordResponseDtoToJson(this);
}
