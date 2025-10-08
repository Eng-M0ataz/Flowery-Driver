
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/meta_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/meta_data_entity.dart';

extension MetaDataMapper on MetaDataDto {
  MetadataEntity toEntity() => MetadataEntity(
    currentPage: currentPage ?? 0,
    totalPages: totalPages ?? 0,
    limit: limit ?? 0,
    totalItems: totalItems ?? 0,
  );
}