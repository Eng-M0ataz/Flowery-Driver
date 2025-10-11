class MetaDataEntity {
  MetaDataEntity ({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? limit;
}