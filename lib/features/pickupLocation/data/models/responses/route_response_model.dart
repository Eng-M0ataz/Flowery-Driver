import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_response_model.g.dart';

@JsonSerializable()
class RouteResponseModel {
  final List<RouteLegModel>? routes;

  RouteResponseModel({this.routes});

  factory RouteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseModelFromJson(json);
}

@JsonSerializable()
class RouteLegModel {
  final RoutePolylineModel? polyline;
  final RouteDistanceModel? distanceMeters;
  final RouteDurationModel? duration;

  RouteLegModel({this.polyline, this.distanceMeters, this.duration});

  factory RouteLegModel.fromJson(Map<String, dynamic> json) =>
      _$RouteLegModelFromJson(json);
}

@JsonSerializable()
class RoutePolylineModel {
  final String? encodedPolyline;
  RoutePolylineModel({this.encodedPolyline});

  factory RoutePolylineModel.fromJson(Map<String, dynamic> json) =>
      _$RoutePolylineModelFromJson(json);
}

@JsonSerializable()
class RouteDistanceModel {
  final double? value;
  RouteDistanceModel({this.value});

  factory RouteDistanceModel.fromJson(Map<String, dynamic> json) =>
      _$RouteDistanceModelFromJson(json);
}

@JsonSerializable()
class RouteDurationModel {
  final double? value;
  RouteDurationModel({this.value});

  factory RouteDurationModel.fromJson(Map<String, dynamic> json) =>
      _$RouteDurationModelFromJson(json);
}