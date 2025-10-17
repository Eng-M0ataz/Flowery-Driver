// // pickup_location_view_model.dart
// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flowery_tracking/core/errors/api_results.dart';
// import 'package:flowery_tracking/core/services/real_time_database_service.dart';
// import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
// import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
// import 'package:flowery_tracking/core/functions/call_number.dart';
// import 'package:flowery_tracking/core/functions/open_whatsapp.dart';
// import 'package:flowery_tracking/core/models/order_details_model.dart';
// import 'package:flowery_tracking/features/pickupLocation/api/models/requests/location_request_model.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/useCases/get_route_use_case.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/useCases/update_driver_location_on_server_use_case.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/delivery_map_event.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/delivery_map_state.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:injectable/injectable.dart';
//
// @injectable
class PickupLocationViewModel {}
//   PickupLocationViewModel(
//       @Named(AppConstants.firebaseRealTimeDatabase) this._realTimeDataBaseService,
//       this._updateDriverLocationUseCase,
//       this._getRouteUseCase,
//       ) : super(DeliveryMapState()) {
//     on<InitializePickupLocationEvent>(_onInitialize);
//     on<UpdateDriverLocationEvent>(_onUpdateDriverLocation);
//     on<SelectStoreCardEvent>(_onSelectStoreCard);
//     on<SelectUserCardEvent>(_onSelectUserCard);
//     on<CallStoreEvent>(_onCallStore);
//     on<CallUserEvent>(_onCallUser);
//     on<OpenStoreWhatsAppEvent>(_onOpenStoreWhatsApp);
//     on<OpenUserWhatsAppEvent>(_onOpenUserWhatsApp);
//     on<AnimateCameraToLocationEvent>(_onAnimateCameraToLocation);
//     on<DisposePickupLocationEvent>(_onDispose);
//   }
//
//   final RealTimeDataBaseService _realTimeDataBaseService;
//   final UpdateDriverLocationOnServerUseCase _updateDriverLocationUseCase;
//   final GetRouteUseCase _getRouteUseCase;
//
//   OrderDetailsModel? _orderDetails;
//   StreamSubscription? _locationStreamSubscription;
//   GoogleMapController? _mapController;
//
//   // Setters for external dependencies
//   void setMapController(GoogleMapController controller) {
//     _mapController = controller;
//   }
//
//   void setOrderDetails(OrderDetailsModel orderDetails) {
//     _orderDetails = orderDetails;
//   }
//
//   // Event Handlers
//
//   Future<void> _onInitialize(
//       InitializePickupLocationEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     emit(state.copyWith(isLoading: true));
//
//     try {
//       // Create delivery locations from order details
//       final deliveryLocations = [
//         DeliveryLocation(
//           id: 'store',
//           title: _orderDetails!.storeInfo.name,
//           address: _orderDetails!.storeInfo.address,
//           latitude: 0, // Will be updated from Firebase
//           longitude: 0,
//           imageUrl: _orderDetails!.storeInfo.imageUrl,
//           phoneNumber: _orderDetails!.storeInfo.phone,
//           isStore: true,
//         ),
//         DeliveryLocation(
//           id: 'user',
//           title: _orderDetails!.userInfo.name,
//           address: _orderDetails!.userInfo.address,
//           latitude: 0, // Will be updated from Firebase
//           longitude: 0,
//           imageUrl: _orderDetails!.userInfo.photoUrl,
//           phoneNumber: _orderDetails!.userInfo.phone,
//           isStore: false,
//         ),
//       ];
//
//       emit(state.copyWith(deliveryLocations: deliveryLocations));
//
//       // Listen to Firebase Realtime Database for location updates
//       _locationStreamSubscription = _realTimeDataBaseService
//           .listenData('orders/${event.orderId}/location')
//           .listen((data) async {
//         if (data != null && data is Map) {
//           await _handleLocationUpdate(data, emit);
//         }
//       });
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Failed to initialize: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _handleLocationUpdate(
//       Map data,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     try {
//       final storeData = data['store'] as Map?;
//       final userData = data['user'] as Map?;
//       final driverData = data['driver'] as Map?;
//
//       LatLng? storeLocation;
//       LatLng? userLocation;
//       LatLng? driverLocation;
//
//       // Parse store location
//       if (storeData != null) {
//         storeLocation = LatLng(
//           (storeData['latitude'] as num).toDouble(),
//           (storeData['longitude'] as num).toDouble(),
//         );
//       }
//
//       // Parse user location
//       if (userData != null) {
//         userLocation = LatLng(
//           (userData['latitude'] as num).toDouble(),
//           (userData['longitude'] as num).toDouble(),
//         );
//       }
//
//       // Parse driver location
//       if (driverData != null) {
//         driverLocation = LatLng(
//           (driverData['latitude'] as num).toDouble(),
//           (driverData['longitude'] as num).toDouble(),
//         );
//       }
//
//       // Update delivery locations with actual coordinates
//       final updatedLocations = state.deliveryLocations.map((loc) {
//         if (loc.isStore && storeLocation != null) {
//           return loc.copyWith(
//             latitude: storeLocation.latitude,
//             longitude: storeLocation.longitude,
//           );
//         } else if (!loc.isStore && userLocation != null) {
//           return loc.copyWith(
//             latitude: userLocation.latitude,
//             longitude: userLocation.longitude,
//           );
//         }
//         return loc;
//       }).toList();
//
//       // Create markers for all locations
//       final markers = await _createMarkers(
//         driverLocation: driverLocation,
//         storeLocation: storeLocation,
//         userLocation: userLocation,
//       );
//
//       emit(state.copyWith(
//         driverLocation: driverLocation,
//         storeLocation: storeLocation,
//         userLocation: userLocation,
//         deliveryLocations: updatedLocations,
//         markers: markers,
//         isLoading: false,
//         isInitialized: true,
//         errorMessage: null,
//       ));
//
//       // Animate camera to driver location on first load
//       if (driverLocation != null && _mapController != null && !state.isInitialized) {
//         _animateCameraToPosition(driverLocation);
//       }
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: 'Error parsing location data: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onUpdateDriverLocation(
//       UpdateDriverLocationEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_orderDetails == null) {
//       emit(state.copyWith(
//         errorMessage: 'Order details not set',
//       ));
//       return;
//     }
//
//     try {
//       final locationModel = LocationRequestModel(
//         latitude: event.latitude,
//         longitude: event.longitude,
//       );
//
//       final result = await _updateDriverLocationUseCase.invoke(
//         path: 'orders/${_orderDetails!.orderId}/location/driver',
//         locationRequestModel: locationModel,
//       );
//
//       if (result is ApiErrorResult) {
//         emit(state.copyWith(
//           errorMessage: result.failure.errorMessage,
//         ));
//       }
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: 'Failed to update location: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onSelectStoreCard(
//       SelectStoreCardEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (state.driverLocation == null) {
//       emit(state.copyWith(
//         errorMessage: 'Driver location not available',
//       ));
//       return;
//     }
//
//     if (state.storeLocation == null) {
//       emit(state.copyWith(
//         errorMessage: 'Store location not available',
//       ));
//       return;
//     }
//
//     // If already selected, deselect
//     if (state.selectedCardIndex == 0) {
//       emit(state.copyWith(
//         selectedCardIndex: null,
//         polylines: {},
//         currentRoute: null,
//       ));
//       return;
//     }
//
//     emit(state.copyWith(
//       isLoading: true,
//       selectedCardIndex: 0, // Store is at index 0
//     ));
//
//     try {
//       // Get route from Google Routes API
//       final route = await _getRouteUseCase.call(
//         origin: state.driverLocation!,
//         destination: state.storeLocation!,
//       );
//
//       // Create polyline for the route
//       final polyline = Polyline(
//         polylineId: const PolylineId('store_route'),
//         points: route.polylinePoints,
//         color: const Color(0xFFD21E6A),
//         width: 5,
//         patterns: [
//           PatternItem.dash(20),
//           PatternItem.gap(10),
//         ],
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//       );
//
//       emit(state.copyWith(
//         polylines: {polyline},
//         currentRoute: route,
//         isLoading: false,
//         errorMessage: null,
//       ));
//
//       // Animate camera to show the full route
//       if (_mapController != null && route.polylinePoints.isNotEmpty) {
//         await _animateCameraToRoute(route.polylinePoints);
//       }
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         selectedCardIndex: null,
//         errorMessage: 'Failed to calculate route: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onSelectUserCard(
//       SelectUserCardEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (state.driverLocation == null) {
//       emit(state.copyWith(
//         errorMessage: 'Driver location not available',
//       ));
//       return;
//     }
//
//     if (state.userLocation == null) {
//       emit(state.copyWith(
//         errorMessage: 'User location not available',
//       ));
//       return;
//     }
//
//     // If already selected, deselect
//     if (state.selectedCardIndex == 1) {
//       emit(state.copyWith(
//         selectedCardIndex: null,
//         polylines: {},
//         currentRoute: null,
//       ));
//       return;
//     }
//
//     emit(state.copyWith(
//       isLoading: true,
//       selectedCardIndex: 1, // User is at index 1
//     ));
//
//     try {
//       // Get route from Google Routes API
//       final route = await _getRouteUseCase.call(
//         origin: state.driverLocation!,
//         destination: state.userLocation!,
//       );
//
//       // Create polyline for the route
//       final polyline = Polyline(
//         polylineId: const PolylineId('user_route'),
//         points: route.polylinePoints,
//         color: const Color(0xFFD21E6A),
//         width: 5,
//         patterns: [
//           PatternItem.dash(20),
//           PatternItem.gap(10),
//         ],
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//       );
//
//       emit(state.copyWith(
//         polylines: {polyline},
//         currentRoute: route,
//         isLoading: false,
//         errorMessage: null,
//       ));
//
//       // Animate camera to show the full route
//       if (_mapController != null && route.polylinePoints.isNotEmpty) {
//         await _animateCameraToRoute(route.polylinePoints);
//       }
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         selectedCardIndex: null,
//         errorMessage: 'Failed to calculate route: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onCallStore(
//       CallStoreEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_orderDetails?.storeInfo.phone == null) {
//       emit(state.copyWith(
//         errorMessage: 'Store phone number not available',
//       ));
//       return;
//     }
//
//     try {
//       await callNumber(_orderDetails!.storeInfo.phone);
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: 'Failed to make call: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onCallUser(
//       CallUserEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_orderDetails?.userInfo.phone == null) {
//       emit(state.copyWith(
//         errorMessage: 'User phone number not available',
//       ));
//       return;
//     }
//
//     try {
//       await callNumber(_orderDetails!.userInfo.phone);
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: 'Failed to make call: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onOpenStoreWhatsApp(
//       OpenStoreWhatsAppEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_orderDetails?.storeInfo.phone == null) {
//       emit(state.copyWith(
//         errorMessage: 'Store phone number not available',
//       ));
//       return;
//     }
//
//     try {
//       await openWhatsApp(
//         _orderDetails!.storeInfo.phone,
//         message: 'Hello, I am the delivery driver for order #${_orderDetails!.orderNumber}',
//       );
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: 'Failed to open WhatsApp: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onOpenUserWhatsApp(
//       OpenUserWhatsAppEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_orderDetails?.userInfo.phone == null) {
//       emit(state.copyWith(
//         errorMessage: 'User phone number not available',
//       ));
//       return;
//     }
//
//     try {
//       await openWhatsApp(
//         _orderDetails!.userInfo.phone,
//         message: 'Hello, I am your delivery driver for order #${_orderDetails!.orderNumber}',
//       );
//     } catch (e) {
//       emit(state.copyWith(
//         errorMessage: 'Failed to open WhatsApp: ${e.toString()}',
//       ));
//     }
//   }
//
//   Future<void> _onAnimateCameraToLocation(
//       AnimateCameraToLocationEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     if (_mapController != null) {
//       _animateCameraToPosition(
//         LatLng(event.latitude, event.longitude),
//       );
//     }
//   }
//
//   Future<void> _onDispose(
//       DisposePickupLocationEvent event,
//       Emitter<PickupLocationState> emit,
//       ) async {
//     await _locationStreamSubscription?.cancel();
//     _locationStreamSubscription = null;
//     _mapController?.dispose();
//     _mapController = null;
//   }
//
//   // Helper Methods
//
//   Future<Set<Marker>> _createMarkers({
//     LatLng? driverLocation,
//     LatLng? storeLocation,
//     LatLng? userLocation,
//   }) async {
//     final markers = <Marker>{};
//
//     try {
//       // Driver marker
//       if (driverLocation != null) {
//         final driverIcon = await _getBitmapDescriptorFromSvgAsset(
//           Assets.assetsImagesFrame3,
//           size: 120,
//         );
//
//         markers.add(
//           Marker(
//             markerId: const MarkerId('driver'),
//             position: driverLocation,
//             icon: driverIcon,
//             anchor: const Offset(0.5, 0.5),
//             infoWindow: const InfoWindow(title: 'Your Location'),
//           ),
//         );
//       }
//
//       // Store marker
//       if (storeLocation != null) {
//         final storeIcon = await _getBitmapDescriptorFromSvgAsset(
//           Assets.assetsImagesFrame2,
//           size: 120,
//         );
//
//         markers.add(
//           Marker(
//             markerId: const MarkerId('store'),
//             position: storeLocation,
//             icon: storeIcon,
//             anchor: const Offset(0.5, 0.5),
//             infoWindow: InfoWindow(
//               title: _orderDetails?.storeInfo.name ?? 'Flowery',
//             ),
//           ),
//         );
//       }
//
//       // User marker
//       if (userLocation != null) {
//         final userIcon = await _getBitmapDescriptorFromSvgAsset(
//           Assets.assetsImagesUserLocation,
//           size: 120,
//         );
//
//         markers.add(
//           Marker(
//             markerId: const MarkerId('user'),
//             position: userLocation,
//             icon: userIcon,
//             anchor: const Offset(0.5, 0.5),
//             infoWindow: InfoWindow(
//               title: _orderDetails?.userInfo.name ?? 'Customer',
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error creating markers: $e');
//     }
//
//     return markers;
//   }
//
//   Future<BitmapDescriptor> _getBitmapDescriptorFromSvgAsset(
//       String assetPath, {
//         int size = 100,
//       }) async {
//     try {
//       // Load SVG from assets
//       final svgString = await rootBundle.loadString(assetPath);
//
//       // Parse SVG
//       final pictureInfo = await vg.loadPicture(
//         SvgStringLoader(svgString),
//         null,
//       );
//
//       // Create a canvas to draw the SVG
//       final recorder = ui.PictureRecorder();
//       final canvas = Canvas(recorder);
//
//       // Calculate scale to fit the size
//       final svgSize = pictureInfo.size;
//       final scale = size / svgSize.width;
//
//       // Draw scaled SVG
//       canvas.scale(scale);
//       canvas.drawPicture(pictureInfo.picture);
//
//       // Convert to image
//       final image = await recorder.endRecording().toImage(
//         size,
//         (size * (svgSize.height / svgSize.width)).round(),
//       );
//
//       // Convert to bytes
//       final byteData = await image.toByteData(
//         format: ui.ImageByteFormat.png,
//       );
//
//       final bytes = byteData!.buffer.asUint8List();
//
//       return BitmapDescriptor.fromBytes(bytes);
//     } catch (e) {
//       debugPrint('Error loading SVG marker: $e');
//       // Return default marker on error
//       return BitmapDescriptor.defaultMarker;
//     }
//   }
//
//   void _animateCameraToPosition(LatLng position) {
//     _mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: position,
//           zoom: 15,
//         ),
//       ),
//     );
//   }
//
//   Future<void> _animateCameraToRoute(List<LatLng> points) async {
//     if (points.isEmpty || _mapController == null) return;
//
//     try {
//       // Calculate bounds that include all points
//       double minLat = points.first.latitude;
//       double maxLat = points.first.latitude;
//       double minLng = points.first.longitude;
//       double maxLng = points.first.longitude;
//
//       for (final point in points) {
//         if (point.latitude < minLat) minLat = point.latitude;
//         if (point.latitude > maxLat) maxLat = point.latitude;
//         if (point.longitude < minLng) minLng = point.longitude;
//         if (point.longitude > maxLng) maxLng = point.longitude;
//       }
//
//       final bounds = LatLngBounds(
//         southwest: LatLng(minLat, minLng),
//         northeast: LatLng(maxLat, maxLng),
//       );
//
//       // Animate camera to show full route with padding
//       await _mapController!.animateCamera(
//         CameraUpdate.newLatLngBounds(bounds, 100),
//       );
//     } catch (e) {
//       debugPrint('Error animating camera: $e');
//     }
//   }
//
//   @override
//   Future<void> close() {
//     _locationStreamSubscription?.cancel();
//     return super.close();
//   }
// }