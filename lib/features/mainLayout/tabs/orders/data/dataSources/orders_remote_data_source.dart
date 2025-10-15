import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_data_entity.dart';

abstract class OrdersRemoteDataSource{
  Future<ApiResult<DriverOrdersResponseEntity>> getDriverOrders();
  Future<ApiResult<ProductDataEntity>> getProduct(String productId);
}
