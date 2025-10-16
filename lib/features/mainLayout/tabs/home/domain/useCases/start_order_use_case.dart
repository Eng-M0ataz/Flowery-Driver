import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class StartOrderUseCase {
  StartOrderUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  Future<ApiResult<StartOrderResponseEntity>> invoke({
    required String orderId,
  }) async {
    return await _homeRepo.startOrder(orderId: orderId);
  }
}
