import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/order_items_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/user_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_items_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/order_items_entity.dart';

extension OrderDtoMapper on OrderDto {
  OrderEntity toEntity() {
    return OrderEntity(
      Id: Id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDelivered: isDelivered,
      isPaid: isPaid,
      orderItems: orderItems!.map((orderItem) => orderItem.toEntity()).toList(),
      user: user!.toEntity(),
      orderNumber: orderNumber,
      paymentType: paymentType,
      state: state,
      totalPrice: totalPrice,
    );
  }
}

