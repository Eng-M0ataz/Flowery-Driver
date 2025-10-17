import 'package:flowery_tracking/core/enum/order_status.dart';

OrderStatus getStatusFromStep(int step) {
  switch (step) {
    case 0:
      return OrderStatus.accepted;
    case 1:
      return OrderStatus.picked;
    case 2:
      return OrderStatus.outfordelivery;
    case 3:
      return OrderStatus.arrived;
    case 4:
      return OrderStatus.delivered;
    default:
      return OrderStatus.accepted;
  }
}
