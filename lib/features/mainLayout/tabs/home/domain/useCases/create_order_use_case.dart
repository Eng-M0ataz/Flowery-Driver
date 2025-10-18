import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateOrderUseCase {
  CreateOrderUseCase(this._repository);

  final HomeRepo _repository;

  Future<ApiResult<void>> invoke({
    required OrderDetailsRequestModel orderDetailsRequestModel,
    required String path,
  }) => _repository.createOrder(
    orderDetailsRequestModel: orderDetailsRequestModel,
    path: path,
  );
}
