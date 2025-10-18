import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';

class DriverOrdersResponseEntity {

  DriverOrdersResponseEntity ({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  final String message;
  final MetaDataEntity metadata;
  final List<AllOrdersEntity> orders;
}












