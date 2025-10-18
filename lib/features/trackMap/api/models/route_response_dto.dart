import 'package:flowery_tracking/features/trackMap/api/models/route_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class RouteResponseDto {

  RouteResponseDto({this.routes});

  factory RouteResponseDto.fromJson(Map<String, dynamic> json) => _$RouteResponseDtoFromJson(json);
  final List<RouteDto>? routes;

}

