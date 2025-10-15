import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_data_entity.dart';

extension ProductItemDtoMapper on ProductItemDto{
  ProductItemEntity toEntity(){
    return ProductItemEntity(
      Id: Id,
      description: description,
      imgCover: imgCover,
      price: price,
      slug: slug,
      title: title,
    );
  }
}