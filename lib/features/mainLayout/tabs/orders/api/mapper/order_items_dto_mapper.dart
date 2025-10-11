import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/product_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_items_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/order_items_entity.dart';

extension OrderItemsDtoMapper on OrderItemsDto{
  OrderItemsEntity toEntity(){
    return OrderItemsEntity(
      product: product!.toEntity(),
      price: price,
      quantity: quantity,
      Id: Id,
    );
  }
}