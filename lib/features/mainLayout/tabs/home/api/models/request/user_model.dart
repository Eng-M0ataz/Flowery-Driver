import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/location_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  const UserModel({required this.userLocation});

  @JsonKey(name: 'location')
  final LocationRequestModel userLocation;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
