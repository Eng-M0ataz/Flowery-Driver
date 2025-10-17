import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateDriverLocationOnServerUseCase {
  UpdateDriverLocationOnServerUseCase(this._repository);
  final OrderDetailsRepo _repository;

  Future<ApiResult<void>> invoke({
    required String path,
    required LocationRequestModel locationRequestModel,
  }) => _repository.updateDriverLocationOnServer(
    locationRequestModel: locationRequestModel,
    path: path,
  );
}
