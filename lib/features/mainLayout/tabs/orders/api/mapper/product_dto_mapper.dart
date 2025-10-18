import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_entity.dart';

extension ProductDtoMapper on ProductDto{
  ProductEntity toEntity(){
    return ProductEntity(
      id: id ?? '',
      price: price ?? 0,
    );
  }
}