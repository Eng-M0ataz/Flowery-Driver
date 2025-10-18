import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';

extension ProductItemDtoMapper on ProductItemDto{
  ProductItemEntity toEntity(){
    return ProductItemEntity(
      id: id ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      price: price ?? 0,
      slug: slug ?? '',
      title: title ?? '',
    );
  }
}