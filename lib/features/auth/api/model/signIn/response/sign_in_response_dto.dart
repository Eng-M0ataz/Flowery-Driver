import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response_dto.g.dart';

@JsonSerializable()
class SignInResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  SignInResponseDto ({
    this.message,
    this.token,
  });

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SignInResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignInResponseDtoToJson(this);
  }
}


