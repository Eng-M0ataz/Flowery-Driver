import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/all_orders_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/meta_data_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/driver_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/driver_orders_response_entity.dart';

extension DriverOrdersDtoMapper on DriverOrdersResponseDto{
  DriverOrdersResponseEntity toEntity(){
    return DriverOrdersResponseEntity(
      message: message,
      metadata: metadata!.toEntity(),
      orders: orders!.map((item)=> item.toEntity()).toList(),
    );
  }
}
