import 'package:flowery_tracking/features/pickupLocation/data/models/requests/location_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreModel {
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  const StoreModel({this.storeLocation});

  @JsonKey(name: 'location')
  final LocationRequestModel? storeLocation;

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
