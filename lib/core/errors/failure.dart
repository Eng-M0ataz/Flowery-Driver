import 'package:dio/dio.dart';

class Failure {
  Failure({required this.errorMessage, this.code = 'No Status Code Found'});
  final String errorMessage;
  final String code;
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage, super.code});

  factory ServerFailure.fromDioError({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: 'Connection timeout with API server.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with API server.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout with API server.');
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage:
              'Connection to API server failed due to an invalid certificate.',
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage:
              'Connection to API was cancelled. Please try again later.',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage:
              'Connection to API server failed due to an internet connection issue.',
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: 'Unexpected error occurred. Please try again later.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response);
    }
  }

  factory ServerFailure.fromResponse(Response? response) {
    if (response == null) {
      return ServerFailure(errorMessage: 'No response received from server.');
    }

    switch (response.statusCode) {
      case 404:
        return ServerFailure(errorMessage: 'Resource not found', code: '404');
      case 500:
        return ServerFailure(
          errorMessage: 'Server error. Please try again later.',
          code: '500',
        );
      default:
        return ServerFailure(
          errorMessage: response.data['message'] ?? response.data['error'],
          code: response.data['code'].toString(),
        );
    }
  }
}
