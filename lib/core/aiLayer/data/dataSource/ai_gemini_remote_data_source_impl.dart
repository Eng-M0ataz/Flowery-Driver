import 'dart:typed_data';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flowery_tracking/core/aiLayer/data/dataSource/ai_remote_data_source.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AiRemoteDataSource)
@Named(AppConstants.gemini)
class AiGeminiRemoteDataSourceImpl implements AiRemoteDataSource {
  final model = FirebaseAI.googleAI().generativeModel(
    model: AppConstants.geminiModel,
  );

  @override
  Future<ApiResult<String>> generateText(String prompt) async {
    try {
      final GenerateContentResponse response = await model.generateContent([
        Content.text(prompt),
      ]);
      return ApiSuccessResult<String>(data: response.text!);
    } on FirebaseAIException catch (e) {
      final Failure failure = Failure(errorMessage: e.message);
      return ApiErrorResult<String>(failure: failure);
    }
  }

  @override
  Future<ApiResult<String>> validateData(
    String prompt,
    Uint8List data,
    String dataType,
  ) async {
    try {
      final GenerateContentResponse response = await model.generateContent([
        Content.inlineData(dataType, data),
        Content.text(prompt),
      ]);
      return ApiSuccessResult<String>(data: response.text!);
    } on FirebaseAIException catch (e) {
      final Failure failure = Failure(errorMessage: e.message);
      return ApiErrorResult<String>(failure: failure);
    }
  }
}
