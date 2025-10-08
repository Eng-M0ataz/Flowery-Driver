import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_store_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_store_entity.dart';

extension PendingStoreDtoMapper on PendingStoreDto {
  PendingStoreEntity toEntity() {
    return PendingStoreEntity(
      name: name ?? LocaleKeys.unknown_user.tr(),
      address: address ?? LocaleKeys.unknown_address.tr(),
      image: image ?? '',
    );
  }
}
