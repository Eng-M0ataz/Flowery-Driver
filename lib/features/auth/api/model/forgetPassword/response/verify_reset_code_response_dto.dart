import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_response_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeResponseDto {
  factory VerifyResetCodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseDtoFromJson(json);

  VerifyResetCodeResponseDto({this.status});
  @JsonKey(name: 'status')
  final String? status;

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseDtoToJson(this);
}
