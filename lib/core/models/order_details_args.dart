class OrderDetailsArgs {
  OrderDetailsArgs({
    required this.storeName,
    required this.storeAddress,
    required this.storeImage,
    required this.userName,
    required this.userPhoto,
    required this.userAddress,
    required this.totalPrice,
  });

  final String storeName;
  final String storeAddress;
  final String storeImage;
  final String userName;
  final String userPhoto;
  final String userAddress;
  final num totalPrice;
}
