import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_dto.g.dart';

@JsonSerializable()
class SignInRequestDto {

  SignInRequestDto ({
    required this.email,
    required this.password,
  });

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SignInRequestDtoFromJson(json);
  }
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  Map<String, dynamic> toJson() {
    return _$SignInRequestDtoToJson(this);
  }
}


