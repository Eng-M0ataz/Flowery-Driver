import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_metadata_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_metadata_entity.dart';

extension PendingMetadataDtoMapper on PendingMetadataDto {
  PendingMetadataEntity toEntity() {
    return PendingMetadataEntity(
      currentPage: currentPage ?? 0,
      totalPages: totalPages ?? 0,
      totalItems: totalItems ?? 0,
      limit: limit ?? 0,
    );
  }
}
