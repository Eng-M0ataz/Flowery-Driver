import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/response/location_response_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';

class GetLocationsUseCase{
  GetLocationsUseCase(this._repo);
  final LocationRepo _repo;

  Future<ApiResult<LocationResponseEntity>> invoke({required String path}){
    return _repo.getLocationsFromServer(path: path);
  }
}