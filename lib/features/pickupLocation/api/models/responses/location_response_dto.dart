import 'package:json_annotation/json_annotation.dart';

part 'location_response_dto.g.dart';

@JsonSerializable()
class LocationResponseDto {
  @JsonKey(name: "driver")
  final DriverDto? driver;
  @JsonKey(name: "store")
  final StoreDto? store;
  @JsonKey(name: "user")
  final UserDto? user;

  LocationResponseDto ({
    this.driver,
    this.store,
    this.user,
  });

  factory LocationResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LocationResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LocationResponseDtoToJson(this);
  }
}

@JsonSerializable()
class DriverDto {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "location")
  final LocationDto? location;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;

  DriverDto ({
    this.firstName,
    this.lastName,
    this.location,
    this.phone,
    this.photo,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return _$DriverDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DriverDtoToJson(this);
  }
}

@JsonSerializable()
class StoreDto {
  @JsonKey(name: "location")
  final LocationDto? location;

  StoreDto ({
    this.location,
  });

  factory StoreDto.fromJson(Map<String, dynamic> json) {
    return _$StoreDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreDtoToJson(this);
  }
}

@JsonSerializable()
class UserDto {
  @JsonKey(name: "location")
  final LocationDto? location;

  UserDto ({
    this.location,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }
}

@JsonSerializable()
class LocationDto {
  @JsonKey(name: "lat")
  final int? lat;
  @JsonKey(name: "long")
  final int? long;

  LocationDto ({
    this.lat,
    this.long,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return _$LocationDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LocationDtoToJson(this);
  }
}