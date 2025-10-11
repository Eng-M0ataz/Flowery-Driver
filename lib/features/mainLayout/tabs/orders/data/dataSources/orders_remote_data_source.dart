import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/driver_orders_response_entity.dart';

abstract class OrdersRemoteDataSource{
  Future<ApiResult<DriverOrdersResponseEntity>> getDriverOrders();
}
