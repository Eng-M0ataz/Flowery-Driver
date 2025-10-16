import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';

abstract class HomeRepo {
  Future<ApiResult<PendingOrdersResponseEntity>> getPendingOrders({
    required int page,
    required int limit,
  });

  Future<ApiResult<StartOrderResponseEntity>> startOrder({
    required String orderId,
  });

  Future<ApiResult<DriverResponseEntity>> getDriverData();

  Future<ApiResult<void>> createOrder({
    required String path,
    required OrderDetailsRequestModel orderDetailsRequestModel,
  });
}
