import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/widgets/order_details_card.dart';
import 'package:flutter/material.dart';

class OrderItemsListView extends StatelessWidget {
  const OrderItemsListView({super.key, required this.productList});
  final List<ProductInfo> productList;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
      itemBuilder: (context, i) => OrderDetailsCard(product: productList[i]),
    );
  }
}
