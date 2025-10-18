import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';

abstract interface class LocationRepo {
  Stream<OrderDetailsEntity> listenData(String path);
}