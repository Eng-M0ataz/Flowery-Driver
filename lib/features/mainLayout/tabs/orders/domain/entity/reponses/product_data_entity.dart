class ProductDataEntity {
  ProductDataEntity ({
    this.message,
    this.product,
  });

  final String? message;
  final ProductItemEntity? product;
}

class ProductItemEntity {
  ProductItemEntity ({
    this.Id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.price,
  });

  final String? Id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final int? price;
}


