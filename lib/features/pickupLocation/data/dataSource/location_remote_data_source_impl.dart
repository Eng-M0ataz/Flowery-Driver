import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/pickupLocation/data/dataSource/location_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  LocationRemoteDataSourceImpl(
      @Named(AppConstants.firebaseRealTimeDatabase)
        this._realTimeDataBaseService
  );
  final RealTimeDataBaseService _realTimeDataBaseService;

  @override
  Stream<dynamic> listenData(String path) {
    return _realTimeDataBaseService
        .listenData(path)
        .handleError((error, stackTrace) {
      throw Exception('Failed to listen to order updates');
    });
  }
}

//
// final data = {
//   "origin": {
//     "location": {"latLng": {"latitude": origin.latitude, "longitude": origin.longitude}}
//   },
//   "destination": {
//     "location": {"latLng": {"latitude": destination.latitude, "longitude": destination.longitude}}
//   },
//   "travelMode": "TWO_WHEELER",
//   "routingPreference": "TRAFFIC_AWARE",
//   "polylineQuality": "HIGH_QUALITY",
//   "polylineEncoding": "ENCODED_POLYLINE"
// };