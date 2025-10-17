class PendingProductEntity {
  const PendingProductEntity({
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

  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final bool? isSuperAdmin;
  final int? sold;
  final int? rateAvg;
  final int? rateCount;
}
