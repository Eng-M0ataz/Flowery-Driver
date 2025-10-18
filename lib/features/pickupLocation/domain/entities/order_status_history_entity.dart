import 'package:flowery_tracking/features/pickupLocation/domain/entities/status_entity.dart';

class OrderStatusHistoryEntity {

  const OrderStatusHistoryEntity({
    this.accepted,
    this.arrived,
    this.picked,
    this.outfordelivery,
    this.delivered,
  });
  final StatusEntity? accepted;
  final StatusEntity? arrived;
  final StatusEntity? picked;
  final StatusEntity? outfordelivery;
  final StatusEntity? delivered;
}
