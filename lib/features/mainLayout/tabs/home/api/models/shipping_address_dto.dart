import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_dto.g.dart';

@JsonSerializable()
class ShippingAddressDto {
  ShippingAddressDto({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDtoFromJson(json);

  @JsonKey(name: 'street')
  final String? street;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'lat')
  final String? lat;

  @JsonKey(name: 'long')
  final String? long;

  Map<String, dynamic> toJson() => _$ShippingAddressDtoToJson(this);
}
