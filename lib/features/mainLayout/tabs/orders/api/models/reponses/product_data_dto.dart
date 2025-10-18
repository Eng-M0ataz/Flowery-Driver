import 'package:json_annotation/json_annotation.dart';

part 'product_data_dto.g.dart';

@JsonSerializable()
class ProductDataDto {

  ProductDataDto ({
    this.message,
    this.product,
  });

  factory ProductDataDto.fromJson(Map<String, dynamic> json) {
    return _$ProductDataDtoFromJson(json);
  }
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'product')
  final ProductItemDto? product;

  Map<String, dynamic> toJson() {
    return _$ProductDataDtoToJson(this);
  }
}

@JsonSerializable()
class ProductItemDto {

  ProductItemDto ({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.price,
  });

  factory ProductItemDto.fromJson(Map<String, dynamic> json) {
    return _$ProductItemDtoFromJson(json);
  }
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'slug')
  final String? slug;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imgCover')
  final String? imgCover;
  @JsonKey(name: 'price')
  final int? price;

  Map<String, dynamic> toJson() {
    return _$ProductItemDtoToJson(this);
  }
}


