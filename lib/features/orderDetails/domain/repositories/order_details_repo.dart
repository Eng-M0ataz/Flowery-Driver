import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';

abstract interface class OrderDetailsRepo {
  Future<ApiResult<void>> updateOrderStatusWithApi({
    required String id,
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  });
  Future<ApiResult<void>> updateOrderStatusOnServer({
    required String path,
    required UpdateOrderStatusWithServerModel updateOrderStatusModel,
  });
  Future<ApiResult<void>> deleteOrder({required String path});

  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  });
}
