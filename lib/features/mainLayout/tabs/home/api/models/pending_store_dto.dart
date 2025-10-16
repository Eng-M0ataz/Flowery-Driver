import 'package:json_annotation/json_annotation.dart';

part 'pending_store_dto.g.dart';

@JsonSerializable()
class PendingStoreDto {
  factory PendingStoreDto.fromJson(Map<String, dynamic> json) {
    return _$PendingStoreDtoFromJson(json);
  }

  PendingStoreDto({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

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
    return _$PendingStoreDtoToJson(this);
  }
}
