import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/product_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_items_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_items_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_entity.dart';

extension OrderItemsDtoMapper on OrderItemsDto{
  OrderItemsEntity toEntity(){
    return OrderItemsEntity(
      product: product?.toEntity() ?? ProductEntity(id: '', price: 0),
      price: price ?? 0,
      quantity: quantity ?? 0,
      id: id ?? '',
    );
  }
}