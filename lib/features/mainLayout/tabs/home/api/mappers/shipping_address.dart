import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/shipping_address_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/shipping_address_entity.dart';

extension ShippingAddressDtoMapper on ShippingAddressDto {
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      street: street??'',
      city: city??'',
      phone: phone??'',
      lat: lat??'',
      long: long??'',
    );
  }
}
