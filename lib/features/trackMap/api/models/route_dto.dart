import 'package:flowery_tracking/features/trackMap/api/models/polyline_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_dto.g.dart';

@JsonSerializable(createToJson: false)
class RouteDto {

  RouteDto({this.polyline});

  factory RouteDto.fromJson(Map<String, dynamic> json) =>
      _$RouteDtoFromJson(json);
  final PolylineDto? polyline;
}