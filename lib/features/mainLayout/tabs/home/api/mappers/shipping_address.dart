import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/shipping_address_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/shipping_address_entity.dart';

extension ShippingAddressDtoMapper on ShippingAddressDto {
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      street: street ?? LocaleKeys.unknown_address.tr(),
      city: city ?? LocaleKeys.unknown_address.tr(),
      phone: phone ?? '',
      lat: lat ?? '',
      long: long ?? '',
    );
  }
}
