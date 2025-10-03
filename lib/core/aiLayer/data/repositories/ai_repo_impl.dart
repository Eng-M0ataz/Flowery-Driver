import 'dart:typed_data';

import 'package:flowery_tracking/core/aiLayer/data/dataSource/ai_remote_data_source.dart';
import 'package:flowery_tracking/core/aiLayer/domain/repositories/ai_repo.dart';
import 'package:flowery_tracking/core/aiLayer/factories/ai_data_source_factory.dart';
import 'package:flowery_tracking/core/enum/ai_service_enum.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AiRepository)
class AiRepoImpl implements AiRepository {
  AiRepoImpl(this._aiDataSourceFactory);
  final AiDataSourceFactory _aiDataSourceFactory;

  @override
  Future<ApiResult<String>> generateText(
    String prompt,
    AiProvider? aiProvider,
  ) {
    return _resolve(aiProvider).generateText(prompt);
  }

  @override
  Future<ApiResult<String>> validateData(
    String prompt,
    Uint8List data,
    String dataType,
    AiProvider? aiProvider,
  ) {
    return _resolve(aiProvider).validateData(prompt, data, dataType);
  }

  AiRemoteDataSource _resolve(AiProvider? aiProvider) =>
      _aiDataSourceFactory.create(aiProvider);
}
