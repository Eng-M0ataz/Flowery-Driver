import 'package:json_annotation/json_annotation.dart';

part 'edit_driver_dto.g.dart';


@JsonSerializable()
class EditDriverDto {

  EditDriverDto ({
    this.role,
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nID,
    this.nIDImg,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.createdAt,
  });

  factory EditDriverDto.fromJson(Map<String, dynamic> json) {
    return _$EditDriverDtoFromJson(json);
  }
  @JsonKey(name: 'role')
  final String? role;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'vehicleType')
  final String? vehicleType;
  @JsonKey(name: 'vehicleNumber')
  final String? vehicleNumber;
  @JsonKey(name: 'vehicleLicense')
  final String? vehicleLicense;
  @JsonKey(name: 'NID')
  final String? nID;
  @JsonKey(name: 'NIDImg')
  final String? nIDImg;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  Map<String, dynamic> toJson() {
    return _$EditDriverDtoToJson(this);
  }
}