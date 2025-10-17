import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_order_item_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_store_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_user_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/shipping_address.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_order_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_store_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_user_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/shipping_address_entity.dart';

extension PendingOrderDtoMapper on PendingOrderDto {
  PendingOrderEntity toEntity() {
    return PendingOrderEntity(
      id: id??'',
      orderNumber: orderNumber??'',
      state: state ?? '',
      paymentType: paymentType ?? '',
      store: store?.toEntity() ??
          PendingStoreEntity(
            image: '',
            address: LocaleKeys.unknown_address.tr(),
            name: LocaleKeys.unknown_user.tr(),
          ),
      user: user?.toEntity() ??
          PendingUserEntity(
            id: '',
            name: LocaleKeys.unknown_user.tr(),
            photo: '',
          ),
      totalPrice: totalPrice ?? 0,
      shippingAddress: shippingAddress?.toEntity() ??
          ShippingAddressEntity(
            street: LocaleKeys.unknown_address.tr(),
            city: '',
          ),
      orderItems: (orderItems ?? [])
          .map((item) => item.toEntity())
          .toList(),
    );
  }
}
