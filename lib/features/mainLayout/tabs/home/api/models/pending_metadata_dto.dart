import 'package:json_annotation/json_annotation.dart';

part 'pending_metadata_dto.g.dart';

@JsonSerializable()
class PendingMetadataDto {
  factory PendingMetadataDto.fromJson(Map<String, dynamic> json) {
    return _$PendingMetadataDtoFromJson(json);
  }

  PendingMetadataDto({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'totalPages')
  final int? totalPages;

  @JsonKey(name: 'totalItems')
  final int? totalItems;

  @JsonKey(name: 'limit')
  final int? limit;

  Map<String, dynamic> toJson() {
    return _$PendingMetadataDtoToJson(this);
  }
}
