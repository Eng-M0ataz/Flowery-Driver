import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase{
  GetProductUseCase({required OrdersRepo ordersRepo})
      : _ordersRepo = ordersRepo;
  final OrdersRepo _ordersRepo;

  Future<ApiResult<ProductDataEntity>> invoke(String productId){
    return _ordersRepo.getProduct(productId);
  }

}