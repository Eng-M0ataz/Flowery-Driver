import 'package:flowery_tracking/features/pickupLocation/data/mapper/request/location_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/user_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/user_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userLocation: userLocation?.toEntity(),
    );
  }
}

extension UserModelMapper on UserEntity {
  UserModel toModel() {
    return UserModel(
      userLocation: userLocation?.toModel(),
    );
  }
}
