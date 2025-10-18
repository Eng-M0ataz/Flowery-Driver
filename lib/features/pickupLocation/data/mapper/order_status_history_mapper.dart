import 'package:flowery_tracking/features/pickupLocation/data/mapper/status_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/order_status_history.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/order_status_history_entity.dart';

extension OrderStatusHistoryMapper on OrderStatusHistory {
  OrderStatusHistoryEntity toEntity() {
    return OrderStatusHistoryEntity(
      accepted: accepted?.toEntity(),
      arrived: arrived?.toEntity(),
      picked: picked?.toEntity(),
      outfordelivery: outfordelivery?.toEntity(),
      delivered: delivered?.toEntity(),
    );
  }
}

extension OrderStatusHistoryModelMapper on OrderStatusHistoryEntity {
  OrderStatusHistory toModel() {
    return OrderStatusHistory(
      accepted: accepted?.toModel(),
      arrived: arrived?.toModel(),
      picked: picked?.toModel(),
      outfordelivery: outfordelivery?.toModel(),
      delivered: delivered?.toModel(),
    );
  }
}
