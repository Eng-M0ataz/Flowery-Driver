import 'package:json_annotation/json_annotation.dart';
part 'logout_response_dto.g.dart';

@JsonSerializable()
class LogoutResponseDto {
  @JsonKey(name: "message")
  final String? message;

  LogoutResponseDto ({
    this.message,
  });

  factory LogoutResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LogoutResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LogoutResponseDtoToJson(this);
  }
}