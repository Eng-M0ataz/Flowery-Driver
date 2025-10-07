import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/update_order_state_response_entity.dart';

abstract class HomeRepo {
  Future<ApiResult<PendingOrdersResponseEntity>> getPendingOrders({
    required int page,
    required int limit,
  });
  Future<ApiResult<UpdateOrderStateResponseEntity>> updateOrderState({
    required String orderId,
    required String state,
  });
}


