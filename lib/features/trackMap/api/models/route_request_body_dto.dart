import 'package:json_annotation/json_annotation.dart';

part 'route_request_body_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RouteRequestBodyDto {

  RouteRequestBodyDto({
    required this.origin,
    required this.destination,
    this.travelMode = "TWO_WHEELER",
    this.routingPreference = "TRAFFIC_AWARE",
  });

  factory RouteRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$RouteRequestBodyDtoFromJson(json);
  final LocationDto origin;
  final LocationDto destination;
  final String travelMode;
  final String routingPreference;
  Map<String, dynamic> toJson() => _$RouteRequestBodyDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationDto {

  LocationDto({required this.location});

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  final LatLngDto location;
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}

@JsonSerializable()
class LatLngDto {

  LatLngDto({required this.latitude, required this.longitude});

  factory LatLngDto.fromJson(Map<String, dynamic> json) =>
      _$LatLngDtoFromJson(json);
  final double latitude;
  final double longitude;
  Map<String, dynamic> toJson() => _$LatLngDtoToJson(this);
}