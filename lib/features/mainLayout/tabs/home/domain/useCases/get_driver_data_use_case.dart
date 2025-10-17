import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDriverDataUseCase {
  GetDriverDataUseCase(this._repository);

  final HomeRepo _repository;

  Future<ApiResult<DriverResponseEntity>> invoke() =>
      _repository.getDriverData();
}
