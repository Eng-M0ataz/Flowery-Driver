import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';

Future<ApiResult<TResult>> executeApi<TDto, TResult>({
  required Future<TDto> Function() request,
  TResult Function(TDto response)? mapper,
}) async {
  try {
    final TDto response = await request();
    if (mapper == null) {
      return ApiSuccessResult<TResult>(data: response as TResult);
    }
    return ApiSuccessResult<TResult>(data: mapper(response));
  } on DioException catch (e) {
    return ApiErrorResult<TResult>(
      failure: ServerFailure.fromDioError(dioException: e),
    );
  } catch (e) {
    return ApiErrorResult<TResult>(
      failure: Failure(errorMessage: e.toString()),
    );
  }
}
