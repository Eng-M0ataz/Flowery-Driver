import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_dto.g.dart';

@JsonSerializable()
class SignInRequestDto {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  SignInRequestDto ({
    this.email,
    this.password,
  });

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SignInRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignInRequestDtoToJson(this);
  }
}


