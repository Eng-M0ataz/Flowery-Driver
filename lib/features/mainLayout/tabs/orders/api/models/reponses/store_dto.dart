import 'package:json_annotation/json_annotation.dart';

part 'store_dto.g.dart';


@JsonSerializable()
class StoreDto {

  StoreDto ({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory StoreDto.fromJson(Map<String, dynamic> json) {
    return _$StoreDtoFromJson(json);
  }
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'latLong')
  final String? latLong;

  Map<String, dynamic> toJson() {
    return _$StoreDtoToJson(this);
  }
}
