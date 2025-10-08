class OrderDetailsModel {
  OrderDetailsModel({
    required this.storeInfo,
    required this.userInfo,
    required this.totalPrice,
    required this.status,
    required this.orderId,
    required this.paymentType,
    required this.productList,
    required this.orderNumber,
    required this.updatedAt,
  });

  final StoreInfo storeInfo;
  final UserInfo userInfo;
  final int? totalPrice;
  final String status;
  final String orderId;
  final String paymentType;
  final List<ProductInfo> productList;
  final String orderNumber;
  final String updatedAt;
}

class StoreInfo {
  StoreInfo({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.phone,
  });

  final String name;
  final String address;
  final String imageUrl;
  final String phone;
}

class UserInfo {
  UserInfo({
    required this.name,
    required this.photoUrl,
    required this.address,
    required this.phone,
  });

  final String name;
  final String photoUrl;
  final String address;
  final String phone;
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
