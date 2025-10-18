import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_request_body_dto.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'track_map_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.googleDirectionsBaseUrl)
@injectable
abstract class TrackMapApiService {
  @factoryMethod
  factory TrackMapApiService(Dio dio) = _TrackMapApiService;

  @POST(ApiConstants.computeRoutes)
  Future<RouteResponseDto> getRoute(
    @Header(ApiConstants.xGoogApiKey) String apiKey,
    @Header(ApiConstants.xGoogFieldMask) String fieldMask,
    @Body() RouteRequestBodyDto body,
  );
}
