import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/functions/image_fixer.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_user_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_user_entity.dart';

extension PendingUserDtoMapper on PendingUserDto {
  PendingUserEntity toEntity() {
    return PendingUserEntity(
      id: id ?? '',
      name: firstName ?? LocaleKeys.unknown_user.tr(),
      photo: imageFixer(photo),
    );
  }
}
