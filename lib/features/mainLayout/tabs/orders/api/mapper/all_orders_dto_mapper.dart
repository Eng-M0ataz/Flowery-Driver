import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/order_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/store_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/all_orders_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/all_orders_entity.dart';

extension AllOrdersDtoMapper on AllOrdersDto{
  AllOrdersEntity toEntity(){
    return AllOrdersEntity(
      updatedAt: updatedAt,
      Id: Id,
      createdAt: createdAt,
      driver: driver,
      order: order?.toEntity(),
      store: store?.toEntity(),
    );
  }
}