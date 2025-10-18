import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/data/dataSources/order_details_remote_data_source.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsRepo)
class OrderDetailsRepoImpl implements OrderDetailsRepo {
  OrderDetailsRepoImpl(this._orderDetailsRemoteDataSource);
  final OrderDetailsRemoteDataSource _orderDetailsRemoteDataSource;

  @override
  Future<ApiResult<void>> deleteOrder({required String path}) {
    return _orderDetailsRemoteDataSource.deleteOrder(path: path);
  }

  @override
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  }) {
    return _orderDetailsRemoteDataSource.updateDriverLocationOnServer(
      locationRequestModel: locationRequestModel,
      path: path,
    );
  }

  @override
  Future<ApiResult<void>> updateOrderStatusOnServer({
    required String path,
    required UpdateOrderStatusWithServerModel updateOrderStatusModel,
  }) {
    return _orderDetailsRemoteDataSource.updateOrderStatusOnServer(
      path: path,
      updateOrderStatusModel: updateOrderStatusModel,
    );
  }

  @override
  Future<ApiResult<void>> updateOrderStatusWithApi({
    required String id,
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  }) {
    return _orderDetailsRemoteDataSource.updateOrderStatusWithApi(
      id: id,
      UpdateOrderStatusWithApiModel: UpdateOrderStatusWithApiModel,
    );
  }
}
