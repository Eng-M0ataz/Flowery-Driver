import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_request.g.dart';

@JsonSerializable()
class VerifyResetCodeRequest {
  VerifyResetCodeRequest({required this.resetCode});

  factory VerifyResetCodeRequest.fromDomain(
    VerifyResetCodeRequestEntity entity,
  ) {
    return VerifyResetCodeRequest(resetCode: entity.resetCode);
  }

  factory VerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestFromJson(json);
  @JsonKey(name: 'resetCode')
  final String resetCode;

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
}
