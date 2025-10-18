import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/data/dataSources/home_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this._homeRemoteDataSource);

  final HomeRemoteDataSource _homeRemoteDataSource;

  @override
  Future<ApiResult<PendingOrdersResponseEntity>> getPendingOrders({
    required int page,
    required int limit,
  }) {
    return _homeRemoteDataSource.getPendingOrders(page: page, limit: limit);
  }

  @override
  Future<ApiResult<StartOrderResponseEntity>> startOrder({
    required String orderId,
  }) {
    return _homeRemoteDataSource.startOrder(orderId: orderId);
  }

  @override
  Future<ApiResult<DriverResponseEntity>> getDriverData() =>
      _homeRemoteDataSource.getDriverData();

  @override
  Future<ApiResult<void>> createOrder({
    required String path,
    required OrderDetailsRequestModel orderDetailsRequestModel,
  }) async {
    return _homeRemoteDataSource.createOrder(
      path: path,
      orderDetailsRequestModel: orderDetailsRequestModel,
    );
  }
}
