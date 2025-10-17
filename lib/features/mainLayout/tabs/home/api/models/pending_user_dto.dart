import 'package:json_annotation/json_annotation.dart';

part 'pending_user_dto.g.dart';

@JsonSerializable()
class PendingUserDto {
  factory PendingUserDto.fromJson(Map<String, dynamic> json) {
    return _$PendingUserDtoFromJson(json);
  }

  PendingUserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordChangedAt,
  });

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'passwordChangedAt')
  final String? passwordChangedAt;

  Map<String, dynamic> toJson() {
    return _$PendingUserDtoToJson(this);
  }
}
