import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {


  EditProfileRequestModel ({
    this.lastName,
    this.firstName,
    this.email,
    this.phone,
    this.gender,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return _$EditProfileRequestModelFromJson(json);
  }
  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'gender')
  final String? gender;

  Map<String, dynamic> toJson() {
    return _$EditProfileRequestModelToJson(this);
  }
}


