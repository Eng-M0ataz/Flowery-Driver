import 'package:json_annotation/json_annotation.dart';

part 'vehicle_meta_data_dto.g.dart';

@JsonSerializable()
class Metadata {
  const Metadata({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'limit')
  final int? limit;
  @JsonKey(name: 'totalItems')
  final int? totalItems;

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
