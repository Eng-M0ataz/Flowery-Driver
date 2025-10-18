// import 'package:flowery_tracking/core/di/di.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/entities/delivery_location.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/entities/driver_entity.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/entities/store_entity.dart';
// import 'package:flowery_tracking/features/pickupLocation/domain/entities/user_entity.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_event.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_state.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_view_model.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/widgets/custom_google_map.dart';
// import 'package:flowery_tracking/features/pickupLocation/presentation/widgets/delivery_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class DeliveryMapScreen extends StatefulWidget {
//   const DeliveryMapScreen({super.key, required this.orderId});
//   final String orderId;
//
//   @override
//   State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
// }
//
// class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
//   late final LocationViewModel _viewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     _viewModel = getIt<LocationViewModel>();
//     // Start listening to order data
//     _viewModel.doIntend(StartListeningOrderEvent(widget.orderId));
//   }
//
//   @override
//   void dispose() {
//     _viewModel.doIntend(StopListeningOrderEvent());
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<LocationViewModel, LocationState>(
//         bloc: _viewModel,
//         builder: (context, state) {
//           if (state.entity == null) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final entity = state.entity!;
//           final driver = entity.driver ?? const DriverEntity();
//           final user = entity.user ?? const UserEntity();
//           final store = entity.store ?? const StoreEntity();
//
//           DeliveryLocation? selectedLocation;
//           if (state.selectedCardIndex != null &&
//               state.selectedCardIndex! < state.deliveryLocations.length) {
//             selectedLocation =
//                 state.deliveryLocations[state.selectedCardIndex!];
//           }
//
//           return Stack(
//             children: [
//               // Google Map
//               CustomGoogleMap(
//                 driver: driver,
//                 user: user,
//                 store: store,
//                 selectedLocation: selectedLocation,
//               ),
//
//               // Bottom Sheet
//               if (state.deliveryLocations.isNotEmpty)
//                 DeliveryBottomSheet(
//                   deliveryLocations: state.deliveryLocations,
//                   selectedCardIndex: state.selectedCardIndex,
//                   onCardTap: (index) {
//                     _viewModel.doIntend(SelectCardEvent(index));
//                   },
//                   onPhoneCall: (phoneNumber) {
//                     // Phone call functionality is handled in DeliveryCard
//                   },
//                   onWhatsApp: (phoneNumber) {
//                     // WhatsApp functionality is handled in DeliveryCard
//                   },
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
// pickup_location_screen.dart
import 'dart:async';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/functions/call_number.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/pickupLocation/data/mapper/store_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_event.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_state.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/viewModel/location_view_model.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/widgets/custom_google_map.dart';
import 'package:flowery_tracking/features/pickupLocation/presentation/widgets/delivery_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/enum/location_return_types.dart';
import 'package:flowery_tracking/core/errors/location_resualt.dart';
import 'package:flowery_tracking/core/services/location_service.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key, required this.path});

  final String path;

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late LocationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<LocationViewModel>();
    _viewModel.doIntend(StartListeningOrderEvent(widget.path));
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: SafeArea(
        child: BlocBuilder<LocationViewModel, LocationState>(
          builder: (context, state) {
            if (state.entity == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final driver = state.entity?.driver;
            final user = state.entity?.user;
            final store = state.entity?.store;

            if (driver == null || user == null || store == null) {
              return Center(
                child: Text('LocaleKeys.waiting_for_driver.tr()'),
              );
            }

            return Stack(
              children: [
                CustomGoogleMap(
                  driver: driver,
                  user: user,
                  store: store,
                ),
                DeliveryBottomSheet(
                    deliveryLocations: state.deliveryLocations,
                    selectedCardIndex: state.selectedCardIndex,
                    onCardTap: (index) {
                      _viewModel.doIntend(SelectCardEvent(index));
                    },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}