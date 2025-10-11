import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/driver_orders_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orders_api_service.g.dart';

@injectable
@RestApi()
abstract class OrdersApiService {
  @factoryMethod
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @GET(ApiConstants.driverOrders)
  Future<DriverOrdersResponseDto> getDriverOrders();
}
