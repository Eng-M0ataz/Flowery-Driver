import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_store_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_store_entity.dart';

extension PendingStoreDtoMapper on PendingStoreDto {
  PendingStoreEntity toEntity() {
    double? lat;
    double? lng;

    if (latLong != null && latLong!.isNotEmpty) {
      final parts = latLong!.split(',');
      if (parts.length == 2) {
        lat = double.tryParse(parts[0].trim());
        lng = double.tryParse(parts[1].trim());
      }
    }

    return PendingStoreEntity(
      name: name ?? LocaleKeys.unknown_user.tr(),
      address: address ?? LocaleKeys.unknown_address.tr(),
      image: image ?? '',
      phone: phoneNumber ?? '',
      lat: lat,
      long: lng,
    );
  }
}
