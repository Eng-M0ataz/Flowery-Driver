import 'package:flowery_tracking/core/functions/image_fixer.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/pending_product_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_product_entity.dart';

extension PendingProductDtoMapper on PendingProductDto {
  PendingProductEntity toEntity() {
    return PendingProductEntity(
      id: id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imageFixer(imgCover),
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      v: v ?? 0,
      isSuperAdmin: isSuperAdmin ?? false,
      sold: sold ?? 0,
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
    );
  }
}
