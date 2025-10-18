import 'package:json_annotation/json_annotation.dart';

part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDto {
  MetaDataDto ({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory MetaDataDto.fromJson(Map<String, dynamic> json) {
    return _$MetaDataDtoFromJson(json);
  }
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'totalItems')
  final int? totalItems;
  @JsonKey(name: 'limit')
  final int? limit;

  Map<String, dynamic> toJson() {
    return _$MetaDataDtoToJson(this);
  }
}