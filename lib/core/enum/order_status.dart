import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';

enum OrderStatus { accepted, picked, outfordelivery, arrived, delivered }

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.accepted:
        return LocaleKeys.accepted.tr();
      case OrderStatus.picked:
        return LocaleKeys.picked.tr();
      case OrderStatus.outfordelivery:
        return LocaleKeys.out_for_delivery.tr();
      case OrderStatus.arrived:
        return LocaleKeys.arrived.tr();
      case OrderStatus.delivered:
        return LocaleKeys.delivered.tr();
    }
  }

  String get buttonDisplayName {
    switch (this) {
      case OrderStatus.accepted:
        return LocaleKeys.arrived_pickup.tr();
      case OrderStatus.picked:
        return LocaleKeys.start_deliver.tr();
      case OrderStatus.outfordelivery:
        return LocaleKeys.arrived_user.tr();
      case OrderStatus.arrived:
        return LocaleKeys.delivered_user.tr();
      case OrderStatus.delivered:
        return LocaleKeys.delivered.tr();
    }
  }
}
