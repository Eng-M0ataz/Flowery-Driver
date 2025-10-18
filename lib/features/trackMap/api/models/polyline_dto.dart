import 'package:json_annotation/json_annotation.dart';

part 'polyline_dto.g.dart';

@JsonSerializable(createToJson: false)
class PolylineDto {

  PolylineDto({this.encodedPolyline});

  factory PolylineDto.fromJson(Map<String, dynamic> json) =>
      _$PolylineDtoFromJson(json);
  final String? encodedPolyline;
}