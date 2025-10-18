import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'order_details_api_service.g.dart';

@RestApi()
@injectable
abstract class OrderDetailsApiService {
  @factoryMethod
  factory OrderDetailsApiService(Dio dio) = _OrderDetailsApiService;
  @PUT(ApiConstants.updateOrderState)
  Future<void> updateOrderStatusOnApi({
    @Path(ApiConstants.id) required String id,
    @Body()
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  });
}
