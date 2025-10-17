import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/order_items_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/user_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/order_items_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_items_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/user_entity.dart';

extension OrderDtoMapper on OrderDto {
  OrderEntity toEntity() {
    return OrderEntity(
      id: id ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      isDelivered: isDelivered ?? false,
      isPaid: isPaid ?? false,
      orderItems: orderItems?.map((orderItem) => orderItem.toEntity()).toList() ?? [],
      user: user?.toEntity() ?? UserEntity(id: '', firstName: '', lastName: '', email: '', gender: '', phone: '', photo: '', passwordChangedAt: ''),
      orderNumber: orderNumber ?? '',
      paymentType: paymentType ?? '',
      state: state ?? '',
      totalPrice: totalPrice ?? 0,
    );
  }
}

