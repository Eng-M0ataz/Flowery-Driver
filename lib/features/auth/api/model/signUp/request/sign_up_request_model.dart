import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  SignUpRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.country,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.nationalId,
    required this.nationalIdImage,
    required this.vehicleLicenseImage,
    required this.confirmPassword,
    required this.gender,
  });
  @JsonKey(name: 'country')
  final String country;
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'vehicleType')
  final String vehicleType;
  @JsonKey(name: 'vehicleNumber')
  final String vehicleNumber;
  @JsonKey(name: 'vehicleLicense')
  final String vehicleLicenseImage;
  @JsonKey(name: 'NID')
  final String nationalId;
  @JsonKey(name: 'NIDImg')
  final String nationalIdImage;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'rePassword')
  final String confirmPassword;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'phone')
  final String phoneNumber;

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}
