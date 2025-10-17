import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateDriverLocationOnServerUseCase {
  UpdateDriverLocationOnServerUseCase(this._repository);
  final LocationRepo _repository;

  Future<ApiResult<void>> updateDriverLocationOnServer({
    required String path,
    required LocationRequestModel locationRequestModel,
  }) => _repository.updateDriverLocationOnServer(
    locationRequestModel: locationRequestModel,
    path: path,
  );
}