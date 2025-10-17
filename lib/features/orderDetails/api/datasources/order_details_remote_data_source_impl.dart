import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/orderDetails/api/client/order_details_api_service.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/data/dataSources/order_details_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  OrderDetailsRemoteDataSourceImpl(
    this._orderDetailsApiService,
    @Named(AppConstants.firebaseRealTimeDatabase) this._realTimeDataBaseService,
    @Named(AppConstants.firebaseRemoteExecutor) this._firebaseRemoteExecutor,
    @Named(AppConstants.apiRemoteExecutor) this._apiRemoteExecutor,
  );
  final OrderDetailsApiService _orderDetailsApiService;
  final RealTimeDataBaseService _realTimeDataBaseService;
  final FirebaseRemoteExecutor _firebaseRemoteExecutor;
  final ApiRemoteExecutor _apiRemoteExecutor;

  @override
  Future<ApiResult<void>> deleteOrder({required String path}) {
    return _firebaseRemoteExecutor.execute<void, void>(
      request: () => _realTimeDataBaseService.delete(path),
    );
  }

  @override
  Future<ApiResult<void>> updateOrderStatusWithApi({
    required String id,
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  }) {
    return _apiRemoteExecutor.execute<void, void>(
      request: () => _orderDetailsApiService.updateOrderStatusOnApi(
        id: id,
        UpdateOrderStatusWithApiModel: UpdateOrderStatusWithApiModel,
      ),
    );
  }

  @override
  Future<ApiResult<void>> updateOrderStatusOnServer({
    required String path,
    required UpdateOrderStatusWithServerModel updateOrderStatusModel,
  }) {
    final data = updateOrderStatusModel.toJson();
    return _firebaseRemoteExecutor.execute<void, void>(
      request: () => _realTimeDataBaseService.update(path, data),
    );
  }

  @override
  Future<ApiResult<void>> updateDriverLocationOnServer({
    required LocationRequestModel locationRequestModel,
    required String path,
  }) async {
    final data = locationRequestModel.toJson();
    return _firebaseRemoteExecutor.execute<void, void>(
      request: () => _realTimeDataBaseService.update(path, data),
    );
  }
}
