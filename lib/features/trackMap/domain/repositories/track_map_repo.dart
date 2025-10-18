import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_request_body_dto.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';

abstract class TrackMapRepo {
  Future<ApiResult<RouteResponseEntity>> getRoute({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  });
}