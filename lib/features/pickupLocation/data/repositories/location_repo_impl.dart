import 'package:flowery_tracking/features/pickupLocation/data/dataSource/location_remote_data_source.dart';
import 'package:flowery_tracking/features/pickupLocation/data/mapper/request/order_details_mapper.dart';
import 'package:flowery_tracking/features/pickupLocation/data/models/requests/order_details_request_model.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/entities/requests/order_details_entity.dart';
import 'package:flowery_tracking/features/pickupLocation/domain/repositories/location_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRepo)
class LocationRepoImpl implements LocationRepo {
  LocationRepoImpl(this._locationRemoteDataSource);
  final LocationRemoteDataSource _locationRemoteDataSource;

  @override
  Stream<OrderDetailsEntity> listenData(String path) {
    return _locationRemoteDataSource.listenData(path).map((jsonData) {
      if (jsonData.isEmpty) {
        return const OrderDetailsEntity();
      }

      try {
        final normalized = _normalizeJsonMap(jsonData);
        final model = OrderDetailsRequestModel.fromJson(normalized);
        return model.toEntity();
      } catch (e) {
        // Return empty entity on parsing error
        return const OrderDetailsEntity();
      }
    });
  }

  Map<String, dynamic> _normalizeJsonMap(Map<dynamic, dynamic> source) {
    final Map<String, dynamic> result = <String, dynamic>{};
    source.forEach((key, value) {
      final String stringKey = key.toString();
      result[stringKey] = _normalizeJsonValue(value);
    });
    return result;
  }

  dynamic _normalizeJsonValue(dynamic value) {
    if (value is Map) {
      return _normalizeJsonMap(value);
    }
    if (value is List) {
      return value.map(_normalizeJsonValue).toList();
    }
    return value;
  }
}