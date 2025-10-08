import 'package:json_annotation/json_annotation.dart';

part 'driver_data_dto.g.dart';

@JsonSerializable()
class DriverDataDto {
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "vehicleType")
  final String? vehicleType;
  @JsonKey(name: "vehicleNumber")
  final String? vehicleNumber;
  @JsonKey(name: "vehicleLicense")
  final String? vehicleLicense;
  @JsonKey(name: "NID")
  final String? NID;
  @JsonKey(name: "NIDImg")
  final String? NIDImg;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  DriverDataDto ({
    this.role,
    this.Id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.NID,
    this.NIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.createdAt,
  });

  factory DriverDataDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverDataDtoToJson(this);
  }
}


