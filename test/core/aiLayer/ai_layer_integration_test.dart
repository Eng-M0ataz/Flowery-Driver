import 'dart:typed_data';

import 'package:flowery_tracking/core/aiLayer/data/dataSource/ai_remote_data_source.dart';
import 'package:flowery_tracking/core/aiLayer/data/repositories/ai_repo_impl.dart';
import 'package:flowery_tracking/core/aiLayer/domain/useCases/generate_text_use_case.dart';
import 'package:flowery_tracking/core/aiLayer/domain/useCases/validate_data_use_case.dart';
import 'package:flowery_tracking/core/aiLayer/factories/ai_data_source_factory.dart';
import 'package:flowery_tracking/core/enum/ai_service_enum.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'ai_layer_integration_test.mocks.dart';
import 'test_helpers.dart';

@GenerateMocks([AiRemoteDataSource])
void main() {
  // Configure dummy values for Mockito
  provideDummy<ApiResult<String>>(provideDummyApiResultString());
  provideDummy<Failure>(provideDummyFailure());
  group('AiLayer Integration Tests', () {
    late MockAiRemoteDataSource mockAiRemoteDataSource;
    late AiDataSourceFactory aiDataSourceFactory;
    late AiRepoImpl aiRepoImpl;
    late GenerateTextUseCase generateTextUseCase;
    late ValidateDataUseCase validateDataUseCase;

    // Dummy data
    const String dummyPrompt = 'Integration test prompt';
    const String dummyGeneratedText = 'Generated response from AI';
    const String dummyValidationResult = 'Data validation successful';
    const String dummyDataType = 'image/jpeg';
    final Uint8List dummyImageData = Uint8List.fromList([
      255,
      216,
      255,
      224,
    ]); // JPEG header
    const String dummyErrorMessage = 'Integration test error';
    const String dummyErrorCode = 'INTEGRATION_ERROR_001';

    setUp(() {
      mockAiRemoteDataSource = MockAiRemoteDataSource();
      aiDataSourceFactory = AiDataSourceFactory(mockAiRemoteDataSource);
      aiRepoImpl = AiRepoImpl(aiDataSourceFactory);
      generateTextUseCase = GenerateTextUseCase(aiRepoImpl);
      validateDataUseCase = ValidateDataUseCase(aiRepoImpl);
    });

    group('Complete Text Generation Flow', () {
      test(
        'should complete full flow from use case to data source for text generation',
        () async {
          // Arrange
          when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
          );

          // Act
          final result = await generateTextUseCase.invoke(
            prompt: dummyPrompt,
            aiProvider: AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          if (result is ApiSuccessResult<String>) {
            expect(result.data, equals(dummyGeneratedText));
          }
          verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
        },
      );

      test('should handle error propagation through complete flow', () async {
        // Arrange
        final dummyFailure = Failure(
          errorMessage: dummyErrorMessage,
          code: dummyErrorCode,
        );
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiErrorResult<String>(failure: dummyFailure),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: dummyPrompt,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiErrorResult<String>>());
        if (result is ApiErrorResult<String>) {
          expect(result.failure.errorMessage, equals(dummyErrorMessage));
        }
        expect(
          (result as ApiErrorResult<String>).failure.code,
          equals(dummyErrorCode),
        );
        verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
      });
    });

    group('Complete Data Validation Flow', () {
      test(
        'should complete full flow from use case to data source for data validation',
        () async {
          // Arrange
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
          );

          // Act
          final result = await validateDataUseCase.invoke(
            prompt: dummyPrompt,
            data: dummyImageData,
            dataType: dummyDataType,
            aiProvider: AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          if (result is ApiSuccessResult<String>) {
            expect(result.data, equals(dummyValidationResult));
          }
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
            ),
          ).called(1);
        },
      );

      test(
        'should handle error propagation through complete validation flow',
        () async {
          // Arrange
          final dummyFailure = Failure(
            errorMessage: dummyErrorMessage,
            code: dummyErrorCode,
          );
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiErrorResult<String>(failure: dummyFailure),
          );

          // Act
          final result = await validateDataUseCase.invoke(
            prompt: dummyPrompt,
            data: dummyImageData,
            dataType: dummyDataType,
            aiProvider: AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiErrorResult<String>>());
          if (result is ApiErrorResult<String>) {
            expect(result.failure.errorMessage, equals(dummyErrorMessage));
          }
          expect(
            (result as ApiErrorResult<String>).failure.code,
            equals(dummyErrorCode),
          );
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
            ),
          ).called(1);
        },
      );
    });

    group('Factory Integration', () {
      test('should use factory to resolve correct data source', () async {
        // Arrange
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final result = await aiRepoImpl.generateText(
          dummyPrompt,
          AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
      });

      test(
        'should use factory to resolve default data source when null provider',
        () async {
          // Arrange
          when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
          );

          // Act
          final result = await aiRepoImpl.generateText(dummyPrompt, null);

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
        },
      );
    });

    group('Multiple Operations Flow', () {
      test('should handle multiple text generation operations', () async {
        // Arrange
        const prompt1 = 'First prompt';
        const prompt2 = 'Second prompt';
        const response1 = 'First response';
        const response2 = 'Second response';

        when(
          mockAiRemoteDataSource.generateText(prompt1),
        ).thenAnswer((_) async => ApiSuccessResult<String>(data: response1));
        when(
          mockAiRemoteDataSource.generateText(prompt2),
        ).thenAnswer((_) async => ApiSuccessResult<String>(data: response2));

        // Act
        final result1 = await generateTextUseCase.invoke(
          prompt: prompt1,
          aiProvider: AiProvider.gemini,
        );
        final result2 = await generateTextUseCase.invoke(
          prompt: prompt2,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result1, isA<ApiSuccessResult<String>>());
        expect((result1 as ApiSuccessResult<String>).data, equals(response1));
        expect(result2, isA<ApiSuccessResult<String>>());
        expect((result2 as ApiSuccessResult<String>).data, equals(response2));
        verify(mockAiRemoteDataSource.generateText(prompt1)).called(1);
        verify(mockAiRemoteDataSource.generateText(prompt2)).called(1);
      });

      test(
        'should handle mixed text generation and validation operations',
        () async {
          // Arrange
          when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
          );
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
          );

          // Act
          final textResult = await generateTextUseCase.invoke(
            prompt: dummyPrompt,
            aiProvider: AiProvider.gemini,
          );
          final validationResult = await validateDataUseCase.invoke(
            prompt: dummyPrompt,
            data: dummyImageData,
            dataType: dummyDataType,
            aiProvider: AiProvider.gemini,
          );

          // Assert
          expect(textResult, isA<ApiSuccessResult<String>>());
          expect(
            (textResult as ApiSuccessResult<String>).data,
            equals(dummyGeneratedText),
          );
          expect(validationResult, isA<ApiSuccessResult<String>>());
          expect(
            (validationResult as ApiSuccessResult<String>).data,
            equals(dummyValidationResult),
          );
          verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
            ),
          ).called(1);
        },
      );
    });

    group('Error Scenarios Integration', () {
      test('should handle partial failures in mixed operations', () async {
        // Arrange
        final dummyFailure = Failure(
          errorMessage: dummyErrorMessage,
          code: dummyErrorCode,
        );
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiErrorResult<String>(failure: dummyFailure),
        );
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
        );

        // Act
        final textResult = await generateTextUseCase.invoke(
          prompt: dummyPrompt,
          aiProvider: AiProvider.gemini,
        );
        final validationResult = await validateDataUseCase.invoke(
          prompt: dummyPrompt,
          data: dummyImageData,
          dataType: dummyDataType,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(textResult, isA<ApiErrorResult<String>>());
        expect(
          (textResult as ApiErrorResult<String>).failure.errorMessage,
          equals(dummyErrorMessage),
        );
        expect(validationResult, isA<ApiSuccessResult<String>>());
        expect(
          (validationResult as ApiSuccessResult<String>).data,
          equals(dummyValidationResult),
        );
      });

      test('should handle complete failure scenarios', () async {
        // Arrange
        final dummyFailure = Failure(
          errorMessage: dummyErrorMessage,
          code: dummyErrorCode,
        );
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiErrorResult<String>(failure: dummyFailure),
        );
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiErrorResult<String>(failure: dummyFailure),
        );

        // Act
        final textResult = await generateTextUseCase.invoke(
          prompt: dummyPrompt,
          aiProvider: AiProvider.gemini,
        );
        final validationResult = await validateDataUseCase.invoke(
          prompt: dummyPrompt,
          data: dummyImageData,
          dataType: dummyDataType,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(textResult, isA<ApiErrorResult<String>>());
        expect(
          (textResult as ApiErrorResult<String>).failure.errorMessage,
          equals(dummyErrorMessage),
        );
        expect(validationResult, isA<ApiErrorResult<String>>());
        expect(
          (validationResult as ApiErrorResult<String>).failure.errorMessage,
          equals(dummyErrorMessage),
        );
      });
    });

    group('Performance Integration', () {
      test('should handle multiple concurrent operations', () async {
        // Arrange
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final futures = List.generate(
          10,
          (index) => generateTextUseCase.invoke(
            prompt: 'Prompt $index',
            aiProvider: AiProvider.gemini,
          ),
        );
        final results = await Future.wait(futures);

        // Assert
        expect(results.length, equals(10));
        for (final result in results) {
          expect(result, isA<ApiSuccessResult<String>>());
          if (result is ApiSuccessResult<String>) {
            expect(result.data, equals(dummyGeneratedText));
          }
        }
        verify(mockAiRemoteDataSource.generateText(any)).called(10);
      });

      test('should handle mixed concurrent operations', () async {
        // Arrange
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
        );

        // Act
        final textFutures = List.generate(
          5,
          (index) => generateTextUseCase.invoke(
            prompt: 'Text prompt $index',
            aiProvider: AiProvider.gemini,
          ),
        );
        final validationFutures = List.generate(
          5,
          (index) => validateDataUseCase.invoke(
            prompt: 'Validation prompt $index',
            data: dummyImageData,
            dataType: dummyDataType,
            aiProvider: AiProvider.gemini,
          ),
        );

        final allFutures = [...textFutures, ...validationFutures];
        final results = await Future.wait(allFutures);

        // Assert
        expect(results.length, equals(10));
        for (int i = 0; i < 5; i++) {
          expect(results[i], isA<ApiSuccessResult<String>>());
          expect(
            (results[i] as ApiSuccessResult<String>).data,
            equals(dummyGeneratedText),
          );
        }
        for (int i = 5; i < 10; i++) {
          expect(results[i], isA<ApiSuccessResult<String>>());
          expect(
            (results[i] as ApiSuccessResult<String>).data,
            equals(dummyValidationResult),
          );
        }
        verify(mockAiRemoteDataSource.generateText(any)).called(5);
        verify(mockAiRemoteDataSource.validateData(any, any, any)).called(5);
      });
    });

    group('Data Flow Validation', () {
      test('should maintain data integrity through the flow', () async {
        // Arrange
        const specificPrompt = 'Specific test prompt with special data';
        const specificResponse = 'Specific response for the test';
        when(mockAiRemoteDataSource.generateText(specificPrompt)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: specificResponse),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: specificPrompt,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        if (result is ApiSuccessResult<String>) {
          expect(result.data, equals(specificResponse));
        }
        verify(mockAiRemoteDataSource.generateText(specificPrompt)).called(1);
      });

      test('should maintain data integrity for validation flow', () async {
        // Arrange
        const specificPrompt = 'Specific validation prompt';
        const specificDataType = 'image/png';
        final specificData = Uint8List.fromList([
          137,
          80,
          78,
          71,
        ]); // PNG header
        const specificResponse = 'Specific validation response';

        when(
          mockAiRemoteDataSource.validateData(
            specificPrompt,
            specificData,
            specificDataType,
          ),
        ).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: specificResponse),
        );

        // Act
        final result = await validateDataUseCase.invoke(
          prompt: specificPrompt,
          data: specificData,
          dataType: specificDataType,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        if (result is ApiSuccessResult<String>) {
          expect(result.data, equals(specificResponse));
        }
        verify(
          mockAiRemoteDataSource.validateData(
            specificPrompt,
            specificData,
            specificDataType,
          ),
        ).called(1);
      });
    });
  });
}
