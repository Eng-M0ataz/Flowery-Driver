import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_metadata_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_order_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_metadata_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';

extension PendingOrdersResponseDtoMapper on PendingOrdersResponseDto {
  PendingOrdersResponseEntity toEntity() {
    return PendingOrdersResponseEntity(
      orders: orders?.map((e) => e.toEntity()).toList() ?? [],
      metadata:
          metadata?.toEntity() ??
          PendingMetadataEntity(
            currentPage: 0,
            totalPages: 0,
            totalItems: 0,
            limit: 0,
          ),
    );
  }
}
