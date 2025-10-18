import 'package:flowery_tracking/features/pickupLocation/data/mapper/driver_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/mapper/order_status_history_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/mapper/store_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/mapper/user_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/requests/order_details_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';

extension OrderDetailsMapper on OrderDetailsRequestModel {
  OrderDetailsEntity toEntity() {
    return OrderDetailsEntity(
      statusHistory: statusHistory?.toEntity(),
      driver: driver?.toEntity(),
      user: user?.toEntity(),
      store: store?.toEntity(),
    );
  }
}

extension OrderDetailsModelMapper on OrderDetailsEntity {
  OrderDetailsRequestModel toModel() {
    return OrderDetailsRequestModel(
      statusHistory: statusHistory?.toModel(),
      driver: driver?.toModel(),
      user: user?.toModel(),
      store: store?.toModel(),
    );
  }
}
