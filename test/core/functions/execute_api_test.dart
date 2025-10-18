import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns success without mapper', () async {
    final result = await executeApi<int, int>(request: () async => 5);
    expect(result, isA<ApiSuccessResult<int>>());
    expect((result as ApiSuccessResult<int>).data, 5);
  });

  test('applies mapper when provided', () async {
    final result = await executeApi<List<int>, int>(
      request: () async => [1, 2, 3],
      mapper: (r) => r.reduce((a, b) => a + b),
    );
    expect(result, isA<ApiSuccessResult<int>>());
    expect((result as ApiSuccessResult<int>).data, 6);
  });

  test('returns error on DioException', () async {
    final result = await executeApi<void, void>(
      request: () async {
        throw DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/x'),
        );
      },
    );
    expect(result, isA<ApiErrorResult<void>>());
  });

  test('returns error on unknown exception', () async {
    final result = await executeApi<void, void>(
      request: () async {
        throw StateError('oops');
      },
    );
    expect(result, isA<ApiErrorResult<void>>());
  });
}
