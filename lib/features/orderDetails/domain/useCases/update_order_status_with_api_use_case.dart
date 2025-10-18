import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStatusWithApiUseCase {
  UpdateOrderStatusWithApiUseCase(this._repository);
  final OrderDetailsRepo _repository;

  Future<ApiResult<void>> invoke({
    required String id,
    required UpdateOrderStatusWithApiModel UpdateOrderStatusWithApiModel,
  }) => _repository.updateOrderStatusWithApi(
    id: id,
    UpdateOrderStatusWithApiModel: UpdateOrderStatusWithApiModel,
  );
}
