import 'package:json_annotation/json_annotation.dart';

part 'driver_dto.g.dart';

@JsonSerializable()
class DriverDto {
  DriverDto({
    this.role,
    this.id,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.createdAt,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDtoFromJson(json);
  }
  String? role;
  @JsonKey(name: '_id')
  String? id;
  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  @JsonKey(name: 'NID')
  String? nid;
  @JsonKey(name: 'NIDImg')
  String? nidImg;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  DateTime? createdAt;

  Map<String, dynamic> toJson() => _$DriverDtoToJson(this);
}
