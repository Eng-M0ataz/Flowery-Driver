import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/meta_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';

extension MetaDataDtoMapper on MetaDataDto{
  MetaDataEntity toEntity(){
    return MetaDataEntity(
      currentPage: currentPage ?? 0,
      totalPages: totalPages ?? 0,
      totalItems: totalItems ?? 0,
      limit: limit ?? 0,
    );
  }
}