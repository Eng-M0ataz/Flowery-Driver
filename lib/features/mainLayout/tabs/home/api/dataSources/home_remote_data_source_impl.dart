import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/client/home_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/dirver_response_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_orders_response_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/start_order_response_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/start_order_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/data/dataSources/home_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(
    this._apiService,
    @Named(AppConstants.firebaseRealTimeDatabase) this._realTimeDataBaseService,
    @Named(AppConstants.firebaseRemoteExecutor) this._firebaseRemoteExecutor,
    @Named(AppConstants.apiRemoteExecutor) this._apiRemoteExecutor,
  );

  final HomeApiService _apiService;
  final RealTimeDataBaseService _realTimeDataBaseService;
  final FirebaseRemoteExecutor _firebaseRemoteExecutor;
  final ApiRemoteExecutor _apiRemoteExecutor;

  @override
  Future<ApiResult<PendingOrdersResponseEntity>> getPendingOrders({
    required int page,
    required int limit,
  }) async {
    return executeApi<PendingOrdersResponseDto, PendingOrdersResponseEntity>(
      request: () => _apiService.getPendingOrders(page: page, limit: limit),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<StartOrderResponseEntity>> startOrder({
    required String orderId,
  }) async {
    return executeApi<StartOrderResponseDto, StartOrderResponseEntity>(
      request: () => _apiService.startOrder(orderId),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<DriverResponseEntity>> getDriverData() =>
      _apiRemoteExecutor.execute<DriverResponseDto, DriverResponseEntity>(
        request: () => _apiService.getDriverData(),
        mapper: (response) => response.toEntity(),
      );

  @override
  Future<ApiResult<void>> createOrder({
    required String path,
    required OrderDetailsRequestModel orderDetailsRequestModel,
  }) {
    final data = orderDetailsRequestModel.toJson();
    return _firebaseRemoteExecutor.execute<void, void>(
      request: () => _realTimeDataBaseService.create(path, data),
    );
  }
}
