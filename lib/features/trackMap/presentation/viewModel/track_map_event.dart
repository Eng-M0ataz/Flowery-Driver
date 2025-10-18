
import 'package:flowery_tracking/features/trackMap/api/models/route_request_body_dto.dart';

abstract class TrackMapEvents {}

class GetRouteEvent extends TrackMapEvents {
  final String apiKey;
  final String fieldMask;
  final RouteRequestBodyDto body;

  GetRouteEvent({
    required this.apiKey,
    required this.fieldMask,
    required this.body,
  });
}