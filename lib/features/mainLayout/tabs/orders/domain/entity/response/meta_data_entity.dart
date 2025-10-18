class MetaDataEntity {
  MetaDataEntity ({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;
}