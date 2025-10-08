import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/update_order_state_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStateUseCase {
  UpdateOrderStateUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  Future<ApiResult<UpdateOrderStateResponseEntity>> invoke({
    required String orderId,
    required String state,
  }) async {
    return await _homeRepo.updateOrderState(orderId: orderId, state: state);
  }
}
