import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/update_order_state_request.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/update_order_state_response_dto.dart';
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
  @PUT('${ApiConstants.updateOrderState}/{${ApiConstants.orderId}}')
  Future<UpdateOrderStateResponseDto> updateOrderState(
      @Path(ApiConstants.orderId) String orderId,
      @Body() UpdateOrderStateRequest body,
      );
}
