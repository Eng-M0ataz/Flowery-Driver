import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/client/orders_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/driver_orders_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/driver_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/data/dataSources/orders_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/driver_orders_response_entity.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl extends OrdersRemoteDataSource {
  OrdersRemoteDataSourceImpl({required OrdersApiService ordersApiService})
    : _ordersApiService = ordersApiService;
  final OrdersApiService _ordersApiService;

  @override
  Future<ApiResult<DriverOrdersResponseEntity>> getDriverOrders() async {
    return executeApi<DriverOrdersResponseDto, DriverOrdersResponseEntity>(
      request: () => _ordersApiService.getDriverOrders(),
      mapper: (data) => data.toEntity(),
    );
  }
}
