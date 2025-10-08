import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/client/home_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_orders_response_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/update_order_state_response_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/update_order_state_request.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/update_order_state_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/data/dataSources/home_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/update_order_state_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._apiService);

  final HomeApiService _apiService;

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
  Future<ApiResult<UpdateOrderStateResponseEntity>> updateOrderState({
    required String orderId,
    required String state,
  }) async {
    final requestBody = UpdateOrderStateRequest(state: state);

    return executeApi<
      UpdateOrderStateResponseDto,
      UpdateOrderStateResponseEntity
    >(
      request: () => _apiService.updateOrderState(orderId, requestBody),
      mapper: (dto) => dto.toEntity(),
    );
  }
}
