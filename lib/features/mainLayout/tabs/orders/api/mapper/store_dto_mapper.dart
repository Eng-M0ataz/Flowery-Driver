import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/store_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/store_entity.dart';

extension StoreDtoMapper on StoreDto{
  StoreEntity toEntity(){
    return StoreEntity(
      name: name ?? '',
      image: image ?? '',
      address: address ?? '',
      phoneNumber: phoneNumber ?? '',
      latLong: latLong ?? '',
    );
  }
}