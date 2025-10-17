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
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.price,
  });

  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final int price;
}


