import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/order_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/store_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/all_orders_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/store_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/user_entity.dart';

extension AllOrdersDtoMapper on AllOrdersDto{
  AllOrdersEntity toEntity() {
    return AllOrdersEntity(
      updatedAt: updatedAt ?? '',
      id: id ?? '',
      createdAt: createdAt ?? '',
      driver: driver ?? '',
      order: order?.toEntity() ?? OrderEntity(id: '',
          user: UserEntity(id: '',
              firstName: '',
              lastName: '',
              email: '',
              gender: '',
              phone: '',
              photo: '',
              passwordChangedAt: ''),
          orderItems: [],
          totalPrice: 0,
          paymentType: '',
          isPaid: false,
          isDelivered: false,
          state: '',
          createdAt: '',
          updatedAt: '',
          orderNumber: ''),
      store: store?.toEntity() ?? StoreEntity(name: '', image: '', address: '', phoneNumber: '', latLong: ''),
    );
  }
}