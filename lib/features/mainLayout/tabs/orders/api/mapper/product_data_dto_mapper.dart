import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/mapper/product_item_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_data_entity.dart';

extension ProductDataDtoMapper on ProductDataDto{
  ProductDataEntity toEntity(){
    return ProductDataEntity(
      message: message,
      product: product?.toEntity(),
    );
  }
}

