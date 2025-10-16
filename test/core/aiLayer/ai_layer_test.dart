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

import 'ai_layer_test.mocks.dart';
import 'test_helpers.dart';

@GenerateMocks([AiRemoteDataSource, AiDataSourceFactory])
void main() {
  // Configure dummy values for Mockito
  provideDummy<ApiResult<String>>(provideDummyApiResultString());
  provideDummy<Failure>(provideDummyFailure());
  group('AiLayer Tests', () {
    late MockAiRemoteDataSource mockAiRemoteDataSource;
    late MockAiDataSourceFactory mockAiDataSourceFactory;
    late AiRepoImpl aiRepoImpl;
    late GenerateTextUseCase generateTextUseCase;
    late ValidateDataUseCase validateDataUseCase;

    // Dummy data
    const String dummyPrompt = 'Test prompt for AI';
    const String dummyGeneratedText = 'Generated AI response text';
    const String dummyValidationResult = 'Validation successful';
    const String dummyDataType = 'image/jpeg';
    final Uint8List dummyImageData = Uint8List.fromList([1, 2, 3, 4, 5]);
    const String dummyErrorMessage = 'AI service error occurred';
    const String dummyErrorCode = 'AI_ERROR_001';

    setUp(() {
      mockAiRemoteDataSource = MockAiRemoteDataSource();
      mockAiDataSourceFactory = MockAiDataSourceFactory();
      aiRepoImpl = AiRepoImpl(mockAiDataSourceFactory);
      generateTextUseCase = GenerateTextUseCase(aiRepoImpl);
      validateDataUseCase = ValidateDataUseCase(aiRepoImpl);
    });

    group('AiRepoImpl Tests', () {
      group('generateText', () {
        test(
          'should return ApiSuccessResult when data source returns success',
          () async {
            // Arrange
            when(
              mockAiDataSourceFactory.create(AiProvider.gemini),
            ).thenReturn(mockAiRemoteDataSource);
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
            if (result is ApiSuccessResult<String>) {
              expect(result.data, equals(dummyGeneratedText));
            }
            verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
            verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
          },
        );

        test(
          'should return ApiErrorResult when data source returns error',
          () async {
            // Arrange
            final dummyFailure = Failure(
              errorMessage: dummyErrorMessage,
              code: dummyErrorCode,
            );
            when(
              mockAiDataSourceFactory.create(AiProvider.gemini),
            ).thenReturn(mockAiRemoteDataSource);
            when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
              (_) async => ApiErrorResult<String>(failure: dummyFailure),
            );

            // Act
            final result = await aiRepoImpl.generateText(
              dummyPrompt,
              AiProvider.gemini,
            );

            // Assert
            expect(result, isA<ApiErrorResult<String>>());
            final errorResult = result as ApiErrorResult<String>;
            expect(errorResult.failure.errorMessage, equals(dummyErrorMessage));
            expect(errorResult.failure.code, equals(dummyErrorCode));
            verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
            verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
          },
        );

        test('should use default provider when null is passed', () async {
          // Arrange
          when(
            mockAiDataSourceFactory.create(null),
          ).thenReturn(mockAiRemoteDataSource);
          when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
          );

          // Act
          final result = await aiRepoImpl.generateText(dummyPrompt, null);

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(mockAiDataSourceFactory.create(null)).called(1);
          verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
        });

        test('should handle empty prompt', () async {
          // Arrange
          const emptyPrompt = '';
          when(
            mockAiDataSourceFactory.create(AiProvider.gemini),
          ).thenReturn(mockAiRemoteDataSource);
          when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
          );

          // Act
          final result = await aiRepoImpl.generateText(
            emptyPrompt,
            AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(mockAiRemoteDataSource.generateText(emptyPrompt)).called(1);
        });
      });

      group('validateData', () {
        test(
          'should return ApiSuccessResult when data validation succeeds',
          () async {
            // Arrange
            when(
              mockAiDataSourceFactory.create(AiProvider.gemini),
            ).thenReturn(mockAiRemoteDataSource);
            when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
              (_) async =>
                  ApiSuccessResult<String>(data: dummyValidationResult),
            );

            // Act
            final result = await aiRepoImpl.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
              AiProvider.gemini,
            );

            // Assert
            expect(result, isA<ApiSuccessResult<String>>());
            expect(
              (result as ApiSuccessResult<String>).data,
              equals(dummyValidationResult),
            );
            verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
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
          'should return ApiErrorResult when data validation fails',
          () async {
            // Arrange
            final dummyFailure = Failure(
              errorMessage: dummyErrorMessage,
              code: dummyErrorCode,
            );
            when(
              mockAiDataSourceFactory.create(AiProvider.gemini),
            ).thenReturn(mockAiRemoteDataSource);
            when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
              (_) async => ApiErrorResult<String>(failure: dummyFailure),
            );

            // Act
            final result = await aiRepoImpl.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
              AiProvider.gemini,
            );

            // Assert
            expect(result, isA<ApiErrorResult<String>>());
            final errorResult = result as ApiErrorResult<String>;
            expect(errorResult.failure.errorMessage, equals(dummyErrorMessage));
            expect(errorResult.failure.code, equals(dummyErrorCode));
            verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
            verify(
              mockAiRemoteDataSource.validateData(
                dummyPrompt,
                dummyImageData,
                dummyDataType,
              ),
            ).called(1);
          },
        );

        test('should use default provider when null is passed', () async {
          // Arrange
          when(
            mockAiDataSourceFactory.create(null),
          ).thenReturn(mockAiRemoteDataSource);
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
          );

          // Act
          final result = await aiRepoImpl.validateData(
            dummyPrompt,
            dummyImageData,
            dummyDataType,
            null,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(mockAiDataSourceFactory.create(null)).called(1);
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
            ),
          ).called(1);
        });

        test('should handle empty data', () async {
          // Arrange
          final emptyData = Uint8List(0);
          when(
            mockAiDataSourceFactory.create(AiProvider.gemini),
          ).thenReturn(mockAiRemoteDataSource);
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
          );

          // Act
          final result = await aiRepoImpl.validateData(
            dummyPrompt,
            emptyData,
            dummyDataType,
            AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              emptyData,
              dummyDataType,
            ),
          ).called(1);
        });

        test('should handle different data types', () async {
          // Arrange
          const pngDataType = 'image/png';
          when(
            mockAiDataSourceFactory.create(AiProvider.gemini),
          ).thenReturn(mockAiRemoteDataSource);
          when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
            (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
          );

          // Act
          final result = await aiRepoImpl.validateData(
            dummyPrompt,
            dummyImageData,
            pngDataType,
            AiProvider.gemini,
          );

          // Assert
          expect(result, isA<ApiSuccessResult<String>>());
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              pngDataType,
            ),
          ).called(1);
        });
      });
    });

    group('GenerateTextUseCase Tests', () {
      test(
        'should call repository generateText with correct parameters',
        () async {
          // Arrange
          when(
            mockAiDataSourceFactory.create(AiProvider.gemini),
          ).thenReturn(mockAiRemoteDataSource);
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
          expect(
            (result as ApiSuccessResult<String>).data,
            equals(dummyGeneratedText),
          );
          verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
          verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
        },
      );

      test('should handle null aiProvider', () async {
        // Arrange
        when(
          mockAiDataSourceFactory.create(null),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: dummyPrompt,
          aiProvider: null,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(mockAiDataSourceFactory.create(null)).called(1);
        verify(mockAiRemoteDataSource.generateText(dummyPrompt)).called(1);
      });

      test('should propagate error from repository', () async {
        // Arrange
        final dummyFailure = Failure(
          errorMessage: dummyErrorMessage,
          code: dummyErrorCode,
        );
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
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
      });
    });

    group('ValidateDataUseCase Tests', () {
      test(
        'should call repository validateData with correct parameters',
        () async {
          // Arrange
          when(
            mockAiDataSourceFactory.create(AiProvider.gemini),
          ).thenReturn(mockAiRemoteDataSource);
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
          expect(
            (result as ApiSuccessResult<String>).data,
            equals(dummyValidationResult),
          );
          verify(mockAiDataSourceFactory.create(AiProvider.gemini)).called(1);
          verify(
            mockAiRemoteDataSource.validateData(
              dummyPrompt,
              dummyImageData,
              dummyDataType,
            ),
          ).called(1);
        },
      );

      test('should handle null aiProvider', () async {
        // Arrange
        when(
          mockAiDataSourceFactory.create(null),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
        );

        // Act
        final result = await validateDataUseCase.invoke(
          prompt: dummyPrompt,
          data: dummyImageData,
          dataType: dummyDataType,
          aiProvider: null,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(mockAiDataSourceFactory.create(null)).called(1);
        verify(
          mockAiRemoteDataSource.validateData(
            dummyPrompt,
            dummyImageData,
            dummyDataType,
          ),
        ).called(1);
      });

      test('should propagate error from repository', () async {
        // Arrange
        final dummyFailure = Failure(
          errorMessage: dummyErrorMessage,
          code: dummyErrorCode,
        );
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
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
      });

      test('should handle different data types', () async {
        // Arrange
        const pdfDataType = 'application/pdf';
        final dummyPdfData = Uint8List.fromList([37, 80, 68, 70]); // PDF header
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
        );

        // Act
        final result = await validateDataUseCase.invoke(
          prompt: dummyPrompt,
          data: dummyPdfData,
          dataType: pdfDataType,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(
          mockAiRemoteDataSource.validateData(
            dummyPrompt,
            dummyPdfData,
            pdfDataType,
          ),
        ).called(1);
      });
    });

    group('AiDataSourceFactory Tests', () {
      late AiDataSourceFactory aiDataSourceFactory;

      setUp(() {
        aiDataSourceFactory = AiDataSourceFactory(mockAiRemoteDataSource);
      });

      test(
        'should return gemini data source when gemini provider is specified',
        () {
          // Act
          final result = aiDataSourceFactory.create(AiProvider.gemini);

          // Assert
          expect(result, equals(mockAiRemoteDataSource));
        },
      );

      test(
        'should return gemini data source as default when null is provided',
        () {
          // Act
          final result = aiDataSourceFactory.create(null);

          // Assert
          expect(result, equals(mockAiRemoteDataSource));
        },
      );

      test('should return gemini data source as default for any provider', () {
        // Act
        final result = aiDataSourceFactory.create(AiProvider.gemini);

        // Assert
        expect(result, equals(mockAiRemoteDataSource));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('should handle very long prompts', () async {
        // Arrange
        final longPrompt = 'A' * 10000; // 10k character prompt
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: longPrompt,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(mockAiRemoteDataSource.generateText(longPrompt)).called(1);
      });

      test('should handle large image data', () async {
        // Arrange
        final largeImageData = Uint8List(1024 * 1024); // 1MB data
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.validateData(any, any, any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyValidationResult),
        );

        // Act
        final result = await validateDataUseCase.invoke(
          prompt: dummyPrompt,
          data: largeImageData,
          dataType: dummyDataType,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(
          mockAiRemoteDataSource.validateData(
            dummyPrompt,
            largeImageData,
            dummyDataType,
          ),
        ).called(1);
      });

      test('should handle special characters in prompt', () async {
        // Arrange
        const specialCharPrompt =
            'Test prompt with special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?';
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: specialCharPrompt,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(
          mockAiRemoteDataSource.generateText(specialCharPrompt),
        ).called(1);
      });

      test('should handle unicode characters in prompt', () async {
        // Arrange
        const unicodePrompt = 'Test prompt with unicode: 你好世界 مرحبا بالعالم 🌍';
        when(
          mockAiDataSourceFactory.create(AiProvider.gemini),
        ).thenReturn(mockAiRemoteDataSource);
        when(mockAiRemoteDataSource.generateText(any)).thenAnswer(
          (_) async => ApiSuccessResult<String>(data: dummyGeneratedText),
        );

        // Act
        final result = await generateTextUseCase.invoke(
          prompt: unicodePrompt,
          aiProvider: AiProvider.gemini,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<String>>());
        verify(mockAiRemoteDataSource.generateText(unicodePrompt)).called(1);
      });
    });
  });
}
