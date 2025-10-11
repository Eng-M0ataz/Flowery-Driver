import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_entity.dart';

extension ProductDtoMapper on ProductDto{
  ProductEntity toEntity(){
    return ProductEntity(
      Id: Id,
      price: price,
    );
  }
}