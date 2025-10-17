import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable()
class StatusModel {
  const StatusModel({
    required this.status,
    required this.statusUpdateDate,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'statusUpdateDate')
  final String statusUpdateDate;

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
