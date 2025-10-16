import 'dart:typed_data';

import 'package:flowery_tracking/core/enum/ai_service_enum.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';

abstract interface class AiRepository {
  Future<ApiResult<String>> generateText(String prompt, AiProvider? aiProvider);
  Future<ApiResult<String>> validateData(
    String prompt,
    Uint8List data,
    String dataType,
    AiProvider? aiProvider,
  );
}
