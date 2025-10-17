import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {

  ProductDto ({
    this.id,
    this.price,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return _$ProductDtoFromJson(json);
  }
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'price')
  final int? price;

  Map<String, dynamic> toJson() {
    return _$ProductDtoToJson(this);
  }
}