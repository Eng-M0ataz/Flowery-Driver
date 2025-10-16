import 'package:json_annotation/json_annotation.dart';

part 'pending_product_dto.g.dart';

@JsonSerializable()
class PendingProductDto {
  factory PendingProductDto.fromJson(Map<String, dynamic> json) {
    return _$PendingProductDtoFromJson(json);
  }

  PendingProductDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

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

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'price')
  final int? price;

  @JsonKey(name: 'priceAfterDiscount')
  final int? priceAfterDiscount;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'occasion')
  final String? occasion;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: '__v')
  final int? v;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'sold')
  final int? sold;

  @JsonKey(name: 'rateAvg')
  final int? rateAvg;

  @JsonKey(name: 'rateCount')
  final int? rateCount;

  Map<String, dynamic> toJson() {
    return _$PendingProductDtoToJson(this);
  }
}
