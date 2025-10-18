import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/location_entity.dart';

class DeliveryLocation {
  const DeliveryLocation({
    required this.title,
    required this.address,
    required this.phoneNumber,
    required this.imageUrl,
    this.location,
    required this.isStore,
  });
  final String title;
  final String address;
  final String phoneNumber;
  final String imageUrl;
  final LocationEntity? location;
  final bool isStore;
}
