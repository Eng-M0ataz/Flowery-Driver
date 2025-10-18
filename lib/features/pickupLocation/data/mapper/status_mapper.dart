import 'package:flowery_tracking/features/pickupLocation/data/models/status_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/status_entity.dart';

extension StatusMapper on StatusModel {
  StatusEntity toEntity() {
    return StatusEntity(
      status: status,
      statusUpdateDate: statusUpdateDate,
    );
  }
}

extension StatusModelMapper on StatusEntity {
  StatusModel toModel() {
    return StatusModel(
      status: status,
      statusUpdateDate: statusUpdateDate,
    );
  }
}
