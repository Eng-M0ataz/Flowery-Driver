import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DriverOrdersUseCase{
  DriverOrdersUseCase({required OrdersRepo ordersRepo})
      : _ordersRepo = ordersRepo;
  final OrdersRepo _ordersRepo;

  Future<ApiResult<DriverOrdersResponseEntity>> invoke(){
    return _ordersRepo.getDriverOrders();
  }
}