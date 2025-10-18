import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_request_body_dto.dart';
import 'package:flowery_tracking/features/trackMap/data/dataSource/track_map_remote_data_source.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';
import 'package:flowery_tracking/features/trackMap/domain/repositories/track_map_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackMapRepo)
class TrackMapRepoImpl implements TrackMapRepo {
  final TrackMapRemoteDataSource _remoteDataSource;

  TrackMapRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<RouteResponseEntity>> getRoute({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  }) async {
    return await _remoteDataSource.getRoute(
      apiKey: apiKey,
      fieldMask: fieldMask,
      body: body,
    );
  }
}