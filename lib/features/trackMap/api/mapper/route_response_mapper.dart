
import 'package:flowery_tracking/features/trackMap/api/models/polyline_dto.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_dto.dart';
import 'package:flowery_tracking/features/trackMap/api/models/route_response_dto.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/polyline_entity.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_entity.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';

extension RouteResponseMapper on RouteResponseDto {
  RouteResponseEntity toEntity() {
    return RouteResponseEntity(
      routes: routes?.map((route) => route.toEntity()).toList(),
    );
  }
}

extension RouteMapper on RouteDto {
  RouteEntity toEntity() {
    return RouteEntity(
      polyline: polyline?.toEntity(),
    );
  }
}

extension PolylineMapper on PolylineDto {
  PolylineEntity toEntity() {
    return PolylineEntity(
      encodedPolyline: encodedPolyline,
    );
  }
}