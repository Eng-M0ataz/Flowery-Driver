import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';

OrderDetailsModel buildOrderDetailsModel({
  required PendingOrderEntity order,
  required HomeState state,
}) {
  final allProducts = order.orderItems!
      .expand((item) => item.productList ?? [])
      .toList();

  return OrderDetailsModel(
    storeInfo: StoreInfo(
      name: order.store!.name!,
      address: order.store!.address!,
      imageUrl: order.store!.image!,
      phone: order.store!.phone!,
      lat: order.store!.lat!,
      long: order.store!.long!,
    ),
    userInfo: UserInfo(
      name: order.user!.name!,
      photoUrl: order.user!.photo!,
      phone: order.user!.phone!,
      address: '${order.shippingAddress!.street!}, ${order.shippingAddress!.city!}',
    ),
    totalPrice: order.totalPrice!,
    status: AppConstants.inProgress,
    orderId: order.id!,
    orderNumber: order.orderNumber!,
    paymentType: order.paymentType!,
    updatedAt: state.startOrderEntity?.updatedAt ?? '',
    productList: allProducts.map(
          (product) => ProductInfo(
        title: product.title!,
        imgCover: product.imgCover!,
        priceAfterDiscount: product.priceAfterDiscount!,
        quantity: product.quantity!,
      ),
    ).toList(),
  );
}
