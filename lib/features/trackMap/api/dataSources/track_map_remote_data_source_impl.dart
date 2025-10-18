import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/trackMap/api/client/track_map_api_service.dart';
import 'package:flowery_tracking/features/trackMap/api/mapper/route_response_mapper.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_request_body_dto.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_response_dto.dart';
import 'package:flowery_tracking/features/trackMap/data/dataSource/track_map_remote_data_source.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackMapRemoteDataSource)
class TrackMapRemoteDataSourceImpl implements TrackMapRemoteDataSource {
  final TrackMapApiService _apiService;

  TrackMapRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<RouteResponseEntity>> getRoute({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  }) async {
    return await executeApi<RouteResponseDto, RouteResponseEntity>(
      request: () => _apiService.getRoute(
          apiKey,
          fieldMask,
          body
      ),
      mapper: (response) => response.toEntity(),
    );
  }
}