import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/driver_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_status_history.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/store_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/user_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flutter/material.dart';

Future<OrderDetailsRequestModel> initializeOrderData({
  required BuildContext context,
  required HomeState state,
  required PendingOrderEntity order,
}) async {
  final driver = state.driverData!.driver!;

  final driverModel = DriverModel(
    firstName: driver.firstName!,
    lastName: driver.lastName!,
    driverPhotoUrl: driver.photo!,
    phone: driver.phone!,
    driverLocation: const LocationRequestModel(
      lat: 30.00901058558408,
      long: 31.24839501695927,
    ),
  );

  final userModel = const UserModel(
    userLocation: LocationRequestModel(
      lat: 30.028958819266784,
      long: 31.259700100900996,
    ),
  );

  final storeModel = const StoreModel(
    storeLocation: LocationRequestModel(
      lat: 30.00901058558408,
      long: 31.24839501695927,
    ),
  );

  return OrderDetailsRequestModel(
    driver: driverModel,
    user: userModel,
    store: storeModel,
    statusHistory: const OrderStatusHistory(),
  );
}
