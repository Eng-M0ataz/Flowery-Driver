import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);

  factory ForgetPasswordRequest.fromDomain(ForgetPasswordRequestEntity entity) {
    return ForgetPasswordRequest(email: entity.email);
  }

  ForgetPasswordRequest({required this.email});
  @JsonKey(name: 'email')
  final String email;

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
