import 'package:json_annotation/json_annotation.dart';

part 'location_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationRequestModel {
  const LocationRequestModel({required this.lat, required this.long});

  factory LocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestModelFromJson(json);
  @JsonKey(name: 'lat')
  final double lat;
  @JsonKey(name: 'long')
  final double long;

  Map<String, dynamic> toJson() => _$LocationRequestModelToJson(this);
}
