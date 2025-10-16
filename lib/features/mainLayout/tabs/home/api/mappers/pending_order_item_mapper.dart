import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_product_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_order_item_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_item_entity.dart';

extension PendingOrderItemDtoMapper on PendingOrderItemDto {
  PendingOrderItemEntity toEntity() {
    return PendingOrderItemEntity(
      productList: product != null ? [product!.toEntity()] : [],
      price: price ?? 0,
      quantity: quantity ?? 0,
      id: id ?? '',
    );
  }
}
