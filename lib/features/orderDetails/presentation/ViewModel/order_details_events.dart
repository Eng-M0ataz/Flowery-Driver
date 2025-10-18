import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';

sealed class OrderDetailsEvents {}

class DeleteOrderEvent extends OrderDetailsEvents {}

class CheckLocationPermissionAndStreamDriverLocation
    extends OrderDetailsEvents {
  CheckLocationPermissionAndStreamDriverLocation({required this.path});

  final String path;
}

class UpdateOrderStatusOnServerEvent extends OrderDetailsEvents {
  UpdateOrderStatusOnServerEvent({
    required this.path,
    required this.updateOrderStatusWithServerModel,
  });
  final String path;
  final UpdateOrderStatusWithServerModel updateOrderStatusWithServerModel;
}

class UpdateOrderStatusWithApiEvent extends OrderDetailsEvents {
  UpdateOrderStatusWithApiEvent({
    required this.orderId,
    required this.updateOrderStatusWithApiModel,
  });
  final String orderId;
  final UpdateOrderStatusWithApiModel updateOrderStatusWithApiModel;
}

class HandleOrderStatusFlowEvent extends OrderDetailsEvents {
  HandleOrderStatusFlowEvent({
    required this.path,
    required this.orderId,
    required this.updateOrderStatusModel,
    required this.updateOrderStatusWithApiModel,
    required this.deletePath,
  });
  final String path;
  final String deletePath;
  final String orderId;
  final UpdateOrderStatusWithServerModel updateOrderStatusModel;
  final UpdateOrderStatusWithApiModel updateOrderStatusWithApiModel;
}
