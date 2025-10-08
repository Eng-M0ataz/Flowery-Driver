import 'package:json_annotation/json_annotation.dart';

part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  MetaDataDto ({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory MetaDataDto.fromJson(Map<String, dynamic> json) {
    return _$MetaDataDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaDataDtoToJson(this);
  }
}


