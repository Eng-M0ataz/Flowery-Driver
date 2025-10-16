import 'package:flowery_tracking/core/aiLayer/domain/repositories/ai_repo.dart';
import 'package:flowery_tracking/core/enum/ai_service_enum.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GenerateTextUseCase {
  GenerateTextUseCase(this._aiRepository);
  final AiRepository _aiRepository;

  Future<ApiResult<String>> invoke({
    AiProvider? aiProvider,
    required String prompt,
  }) async {
    return await _aiRepository.generateText(prompt, aiProvider);
  }
}
