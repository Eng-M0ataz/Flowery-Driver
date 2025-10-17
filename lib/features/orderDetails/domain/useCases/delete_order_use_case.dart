import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteOrderUseCase {
  DeleteOrderUseCase(this._repository);
  final OrderDetailsRepo _repository;

  Future<ApiResult<void>> invoke({required String path}) =>
      _repository.deleteOrder(path: path);
}
