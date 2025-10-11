import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/meta_data_entity.dart';

class DriverOrdersResponseEntity {

  DriverOrdersResponseEntity ({
    this.message,
    this.metadata,
    this.orders,
  });

  final String? message;
  final MetaDataEntity? metadata;
  final List<AllOrdersEntity>? orders;
}












