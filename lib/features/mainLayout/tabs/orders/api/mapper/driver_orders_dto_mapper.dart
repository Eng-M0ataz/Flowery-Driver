import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/all_orders_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/meta_data_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/driver_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';

extension DriverOrdersDtoMapper on DriverOrdersResponseDto{
  DriverOrdersResponseEntity toEntity(){
    return DriverOrdersResponseEntity(
      message: message ?? '',
      metadata: metadata?.toEntity() ?? MetaDataEntity(limit: 0,currentPage: 0,totalItems: 0,totalPages: 0),
      orders: orders?.map((item)=> item.toEntity()).toList() ?? [],
    );
  }
}
