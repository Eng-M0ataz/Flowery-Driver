import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLocationsUseCase{
  GetLocationsUseCase(this._repo);
  final LocationRepo _repo;

  Stream<OrderDetailsEntity> listenData(String path){
    return _repo.listenData(path);
  }
}