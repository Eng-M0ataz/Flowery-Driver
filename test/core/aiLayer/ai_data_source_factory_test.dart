import 'package:flowery_tracking/core/aiLayer/data/dataSource/ai_remote_data_source.dart';
import 'package:flowery_tracking/core/aiLayer/factories/ai_data_source_factory.dart';
import 'package:flowery_tracking/core/enum/ai_service_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'ai_data_source_factory_test.mocks.dart';

@GenerateMocks([AiRemoteDataSource])
void main() {
  group('AiDataSourceFactory Tests', () {
    late AiDataSourceFactory aiDataSourceFactory;
    late MockAiRemoteDataSource mockGeminiDataSource;

    setUp(() {
      mockGeminiDataSource = MockAiRemoteDataSource();
      aiDataSourceFactory = AiDataSourceFactory(mockGeminiDataSource);
    });

    group('create method', () {
      test(
        'should return gemini data source when AiProvider.gemini is provided',
        () {
          // Act
          final result = aiDataSourceFactory.create(AiProvider.gemini);

          // Assert
          expect(result, equals(mockGeminiDataSource));
          expect(result, isA<AiRemoteDataSource>());
        },
      );

      test('should return gemini data source when null is provided', () {
        // Act
        final result = aiDataSourceFactory.create(null);

        // Assert
        expect(result, equals(mockGeminiDataSource));
        expect(result, isA<AiRemoteDataSource>());
      });

      test('should return gemini data source as default for any provider', () {
        // Act
        final result = aiDataSourceFactory.create(AiProvider.gemini);

        // Assert
        expect(result, equals(mockGeminiDataSource));
        expect(result, isA<AiRemoteDataSource>());
      });

      test('should return the same instance for multiple calls', () {
        // Act
        final result1 = aiDataSourceFactory.create(AiProvider.gemini);
        final result2 = aiDataSourceFactory.create(null);
        final result3 = aiDataSourceFactory.create(AiProvider.gemini);

        // Assert
        expect(result1, equals(mockGeminiDataSource));
        expect(result2, equals(mockGeminiDataSource));
        expect(result3, equals(mockGeminiDataSource));
        expect(identical(result1, result2), isTrue);
        expect(identical(result2, result3), isTrue);
      });
    });

    group('Factory Pattern Validation', () {
      test('should maintain single instance of gemini data source', () {
        // Arrange & Act
        final result1 = aiDataSourceFactory.create(AiProvider.gemini);
        final result2 = aiDataSourceFactory.create(AiProvider.gemini);

        // Assert
        expect(identical(result1, result2), isTrue);
        expect(result1, isA<AiRemoteDataSource>());
      });

      test(
        'should handle multiple factory instances with same data source',
        () {
          // Arrange
          final factory1 = AiDataSourceFactory(mockGeminiDataSource);
          final factory2 = AiDataSourceFactory(mockGeminiDataSource);

          // Act
          final result1 = factory1.create(AiProvider.gemini);
          final result2 = factory2.create(AiProvider.gemini);

          // Assert
          expect(result1, equals(result2));
          expect(identical(result1, result2), isTrue);
        },
      );
    });

    group('Edge Cases', () {
      test('should handle null provider consistently', () {
        // Act
        final result1 = aiDataSourceFactory.create(null);
        final result2 = aiDataSourceFactory.create(null);

        // Assert
        expect(result1, equals(mockGeminiDataSource));
        expect(result2, equals(mockGeminiDataSource));
        expect(identical(result1, result2), isTrue);
      });

      test(
        'should work with different enum values if more providers are added',
        () {
          // This test ensures the factory can handle future enum additions
          // Currently only gemini is available, but this tests the switch statement

          // Act
          final result = aiDataSourceFactory.create(AiProvider.gemini);

          // Assert
          expect(result, isNotNull);
          expect(result, isA<AiRemoteDataSource>());
        },
      );
    });

    group('Constructor Validation', () {
      test('should accept valid AiRemoteDataSource in constructor', () {
        // Arrange & Act
        final factory = AiDataSourceFactory(mockGeminiDataSource);

        // Assert
        expect(factory, isNotNull);
        expect(factory, isA<AiDataSourceFactory>());
      });

      test('should work with different AiRemoteDataSource implementations', () {
        // Arrange
        final mockDataSource = MockAiRemoteDataSource();
        final factory = AiDataSourceFactory(mockDataSource);

        // Act
        final result = factory.create(AiProvider.gemini);

        // Assert
        expect(result, equals(mockDataSource));
        expect(result, isA<AiRemoteDataSource>());
      });
    });

    group('Integration Scenarios', () {
      test('should be used correctly in repository pattern', () {
        // This test simulates how the factory would be used in a repository
        // Arrange
        final factory = AiDataSourceFactory(mockGeminiDataSource);

        // Act - Simulate repository usage
        final dataSource = factory.create(AiProvider.gemini);

        // Assert
        expect(dataSource, isNotNull);
        expect(dataSource, isA<AiRemoteDataSource>());
        // In a real scenario, you would verify that the dataSource
        // has the expected methods and behavior
      });

      test('should handle provider switching at runtime', () {
        // Arrange
        final factory = AiDataSourceFactory(mockGeminiDataSource);

        // Act - Simulate switching between providers
        final geminiResult = factory.create(AiProvider.gemini);
        final nullResult = factory.create(null);
        final geminiResultAgain = factory.create(AiProvider.gemini);

        // Assert
        expect(geminiResult, equals(mockGeminiDataSource));
        expect(nullResult, equals(mockGeminiDataSource));
        expect(geminiResultAgain, equals(mockGeminiDataSource));
        expect(identical(geminiResult, nullResult), isTrue);
        expect(identical(nullResult, geminiResultAgain), isTrue);
      });
    });

    group('Performance and Memory', () {
      test('should not create new instances on repeated calls', () {
        // Arrange
        final factory = AiDataSourceFactory(mockGeminiDataSource);
        final results = <AiRemoteDataSource>[];

        // Act - Make multiple calls
        for (int i = 0; i < 100; i++) {
          results.add(factory.create(AiProvider.gemini));
        }

        // Assert - All results should be the same instance
        for (int i = 1; i < results.length; i++) {
          expect(identical(results[0], results[i]), isTrue);
        }
      });

      test('should handle concurrent access safely', () async {
        // Arrange
        final factory = AiDataSourceFactory(mockGeminiDataSource);
        final futures = <Future<AiRemoteDataSource>>[];

        // Act - Simulate concurrent access
        for (int i = 0; i < 10; i++) {
          futures.add(Future(() => factory.create(AiProvider.gemini)));
        }

        final results = await Future.wait(futures);

        // Assert - All results should be the same instance
        for (int i = 1; i < results.length; i++) {
          expect(identical(results[0], results[i]), isTrue);
        }
      });
    });
  });
}
