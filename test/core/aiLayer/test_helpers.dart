import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:mockito/annotations.dart';

// Dummy values for Mockito
@GenerateMocks([])
void main() {}

// Dummy values for ApiResult<String>
ApiResult<String> provideDummyApiResultString() {
  return ApiSuccessResult<String>(data: 'dummy');
}

// Dummy values for Failure
Failure provideDummyFailure() {
  return Failure(errorMessage: 'dummy error');
}

// Dummy values for ApiErrorResult<String>
ApiErrorResult<String> provideDummyApiErrorResultString() {
  return ApiErrorResult<String>(failure: provideDummyFailure());
}

// Dummy values for ApiSuccessResult<String>
ApiSuccessResult<String> provideDummyApiSuccessResultString() {
  return ApiSuccessResult<String>(data: 'dummy success');
}
