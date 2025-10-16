import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/start_order_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'home_api_service.g.dart';

@RestApi()
@injectable
abstract class HomeApiService {
  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(ApiConstants.pendingOrders)
  Future<PendingOrdersResponseDto> getPendingOrders({
    @Query(ApiConstants.queryPage) int? page,
    @Query(ApiConstants.queryLimit) int? limit,
  });
  @PUT('${ApiConstants.startOrder}/{${ApiConstants.orderId}}')
  Future<StartOrderResponseDto> startOrder(
      @Path(ApiConstants.orderId) String orderId,
      );
  @GET(ApiConstants.driverData)
  Future<DriverResponseDto> getDriverData();

}
