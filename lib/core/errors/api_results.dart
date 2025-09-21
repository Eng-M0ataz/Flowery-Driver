import 'package:flowery_tracking/core/errors/failure.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  ApiSuccessResult({required this.data});
  final T data;
}

class ApiErrorResult<T> extends ApiResult<T> {
  ApiErrorResult({required this.failure});
  final Failure failure;
}
