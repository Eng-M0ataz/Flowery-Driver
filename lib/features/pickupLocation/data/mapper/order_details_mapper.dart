import 'package:flowery_tracking/core/models/order_details_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/location_entity.dart';

class OrderDetailsMapper {
  static List<DeliveryLocation> convertToDeliveryLocations(
    OrderDetailsModel orderDetails,
  ) {
    final List<DeliveryLocation> locations = [];

    // Add store location
    locations.add(
      DeliveryLocation(
        title: orderDetails.storeInfo.name,
        address: orderDetails.storeInfo.address,
        phoneNumber: orderDetails.storeInfo.phone,
        imageUrl: orderDetails.storeInfo.imageUrl,
        location: LocationEntity(
          lat: orderDetails.storeInfo.lat,
          long: orderDetails.storeInfo.long,
        ),
        isStore: true,
      ),
    );

    // Add user location
    locations.add(
      DeliveryLocation(
        title: orderDetails.userInfo.name,
        address: orderDetails.userInfo.address,
        phoneNumber: orderDetails.userInfo.phone,
        imageUrl: orderDetails.userInfo.photoUrl,
        location: const LocationEntity(
          lat: 30.065596319414915, // Default coordinates from JSON
          long: 31.418882423663554,
        ),
        isStore: false,
      ),
    );

    return locations;
  }
}
