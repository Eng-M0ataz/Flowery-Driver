import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  ResetPasswordRequest({required this.email, required this.newPassword});

  factory ResetPasswordRequest.fromDomain(ResetPasswordRequestEntity entity) {
    return ResetPasswordRequest(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'newPassword')
  final String newPassword;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
