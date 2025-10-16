import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseRemoteExecutor', () {
    late FirebaseRemoteExecutor executor;

    setUp(() {
      executor = FirebaseRemoteExecutor();
    });

    test('returns success when request completes without mapper', () async {
      final result = await executor.execute<int, int>(request: () async => 123);

      expect(result, isA<ApiSuccessResult<int>>());
      expect((result as ApiSuccessResult<int>).data, 123);
    });

    test('applies mapper when provided and returns success', () async {
      final result = await executor.execute<Map<String, dynamic>, String>(
        request: () async => {'value': 7},
        mapper: (response) => 'mapped-${response['value']}',
      );

      expect(result, isA<ApiSuccessResult<String>>());
      expect((result as ApiSuccessResult<String>).data, 'mapped-7');
    });

    test('returns FirebaseFailure on FirebaseException', () async {
      final result = await executor.execute<void, void>(
        request: () async {
          throw FirebaseException(plugin: 'test', code: 'permission-denied');
        },
      );

      expect(result, isA<ApiErrorResult<void>>());
      final failure = (result as ApiErrorResult<void>).failure;
      expect(failure, isA<FirebaseFailure>());
      expect(failure.code, 'permission-denied');
    });

    test('returns Failure on unknown exception', () async {
      final result = await executor.execute<void, void>(
        request: () async {
          throw StateError('boom');
        },
      );

      expect(result, isA<ApiErrorResult<void>>());
      final failure = (result as ApiErrorResult<void>).failure;
      expect(failure, isA<Failure>());
      expect(failure.errorMessage, contains('Bad state'));
    });
  });

  group('ApiRemoteExecutor', () {
    late ApiRemoteExecutor executor;

    setUp(() {
      executor = ApiRemoteExecutor();
    });

    test('returns success when request completes without mapper', () async {
      final result = await executor.execute<String, String>(
        request: () async => 'ok',
      );

      expect(result, isA<ApiSuccessResult<String>>());
      expect((result as ApiSuccessResult<String>).data, 'ok');
    });

    test('applies mapper when provided and returns success', () async {
      final result = await executor.execute<List<int>, int>(
        request: () async => [1, 2, 3],
        mapper: (response) => response.length,
      );

      expect(result, isA<ApiSuccessResult<int>>());
      expect((result as ApiSuccessResult<int>).data, 3);
    });

    test('returns ServerFailure on DioException', () async {
      final result = await executor.execute<void, void>(
        request: () async {
          throw DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(path: '/test'),
          );
        },
      );

      expect(result, isA<ApiErrorResult<void>>());
      final failure = (result as ApiErrorResult<void>).failure;
      expect(failure, isA<ServerFailure>());
      expect(failure.errorMessage, 'Connection timeout with API server.');
    });

    test('returns Failure on unknown exception', () async {
      final result = await executor.execute<void, void>(
        request: () async {
          throw ArgumentError('bad');
        },
      );

      expect(result, isA<ApiErrorResult<void>>());
      final failure = (result as ApiErrorResult<void>).failure;
      expect(failure, isA<Failure>());
      expect(failure.errorMessage, contains('Invalid argument'));
    });
  });
}
