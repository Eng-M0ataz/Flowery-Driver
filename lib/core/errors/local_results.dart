import 'package:flowery_tracking/core/errors/failure.dart';

sealed class LocalResult<T> {}

class LocalSuccessResult<T> extends LocalResult<T> {
  LocalSuccessResult({required this.data});
  final T data;
}

class LocalErrorResult<T> extends LocalResult<T> {
  LocalErrorResult({required this.failure});
  final Failure failure;
}