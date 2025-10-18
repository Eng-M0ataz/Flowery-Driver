import 'package:json_annotation/json_annotation.dart';

part 'status_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StatusModel {
  const StatusModel({
    this.status,
    this.statusUpdateDate,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) =>
      _$StatusModelFromJson(json);

  final String? status;
  final String? statusUpdateDate;

  Map<String, dynamic> toJson() => _$StatusModelToJson(this);
}
