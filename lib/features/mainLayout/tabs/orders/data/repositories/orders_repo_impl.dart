import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/data/dataSources/orders_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl extends OrdersRepo{
  OrdersRepoImpl({required OrdersRemoteDataSource ordersRemoteDataSource})
      : _ordersRemoteDataSource = ordersRemoteDataSource;
  final OrdersRemoteDataSource _ordersRemoteDataSource;

  @override
  Future<ApiResult<DriverOrdersResponseEntity>> getDriverOrders() {
    return _ordersRemoteDataSource.getDriverOrders();
  }

  @override
  Future<ApiResult<ProductDataEntity>> getProduct(String productId) {
    return _ordersRemoteDataSource.getProduct(productId);
  }

}