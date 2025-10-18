import 'package:flowery_tracking/features/pickupLocation/data/mapper/request/location_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/store_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/store_entity.dart';

extension StoreMapper on StoreModel {
  StoreEntity toEntity() {
    return StoreEntity(
      storeLocation: storeLocation?.toEntity(),
    );
  }
}

extension StoreModelMapper on StoreEntity {
  StoreModel toModel() {
    return StoreModel(
      storeLocation: storeLocation?.toModel(),
    );
  }
}
