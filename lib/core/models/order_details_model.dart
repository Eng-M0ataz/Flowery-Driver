class OrderDetailsModel {
  OrderDetailsModel({
    required this.storeInfo,
    required this.userInfo,
    required this.totalPrice,
    required this.status,
    required this.orderId,
    required this.paymentType,
    required this.productList,
  });

  final StoreInfo storeInfo;
  final UserInfo userInfo;
  final int? totalPrice;
  final String status;
  final String orderId;
  final String paymentType;
  final List<ProductInfo> productList;
}

class StoreInfo {
  StoreInfo({
    required this.name,
    required this.address,
    required this.imageUrl,
  });

  final String name;
  final String address;
  final String imageUrl;
}

class UserInfo {
  UserInfo({required this.name, required this.photoUrl, required this.address});

  final String name;
  final String photoUrl;
  final String address;
}

class ProductInfo {
  ProductInfo({
    required this.title,
    required this.imgCover,
    required this.priceAfterDiscount,
    required this.quantity,
  });

  final String title;
  final String imgCover;
  final int priceAfterDiscount;
  final int quantity;
}
