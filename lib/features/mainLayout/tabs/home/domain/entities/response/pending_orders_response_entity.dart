import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_metadata_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';

class PendingOrdersResponseEntity {
  PendingOrdersResponseEntity({this.orders, this.metadata});

  final List<PendingOrderEntity>? orders;
  final PendingMetadataEntity? metadata;
}
