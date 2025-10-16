import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPendingOrdersUseCase {
  GetPendingOrdersUseCase(this._homeRepo);

  final HomeRepo _homeRepo;

  Future<ApiResult<PendingOrdersResponseEntity>> invoke({required int page ,required int limit}) async {
    return await _homeRepo.getPendingOrders( page: page, limit: limit);
  }
}
