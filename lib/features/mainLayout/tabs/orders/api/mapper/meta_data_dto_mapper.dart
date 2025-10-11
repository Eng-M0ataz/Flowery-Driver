import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/meta_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/meta_data_entity.dart';

extension MetaDataDtoMapper on MetaDataDto{
  MetaDataEntity toEntity(){
    return MetaDataEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      limit: limit,
    );
  }
}