import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';

class Failure {
  Failure({required this.errorMessage, this.code = 'No Status Code Found'});
  final String errorMessage;
  final String code;
}

class FirebaseFailure extends Failure {
  FirebaseFailure({required super.errorMessage, super.code});

  factory FirebaseFailure.fromException(FirebaseException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseFailure(
          errorMessage: 'Invalid email address.',
          code: 'invalid-email',
        );
      case 'user-disabled':
        return FirebaseFailure(
          errorMessage: 'This user account has been disabled.',
          code: 'user-disabled',
        );
      case 'user-not-found':
        return FirebaseFailure(
          errorMessage: 'No user found for the given credentials.',
          code: 'user-not-found',
        );
      case 'wrong-password':
        return FirebaseFailure(
          errorMessage: 'Incorrect password.',
          code: 'wrong-password',
        );
      case 'email-already-in-use':
        return FirebaseFailure(
          errorMessage: 'Email is already in use.',
          code: 'email-already-in-use',
        );
      case 'weak-password':
        return FirebaseFailure(
          errorMessage: 'Password is too weak.',
          code: 'weak-password',
        );
      case 'network-request-failed':
        return FirebaseFailure(
          errorMessage: 'Network error. Please check your internet connection.',
          code: 'network-request-failed',
        );
      case 'too-many-requests':
        return FirebaseFailure(
          errorMessage: 'Too many requests. Please try again later.',
          code: 'too-many-requests',
        );

      case 'permission-denied':
        return FirebaseFailure(
          errorMessage: 'You do not have permission to perform this action.',
          code: 'permission-denied',
        );
      case 'unavailable':
        return FirebaseFailure(
          errorMessage:
              'Service temporarily unavailable. Please try again later.',
          code: 'unavailable',
        );
      case 'not-found':
        return FirebaseFailure(
          errorMessage: 'Requested data not found.',
          code: 'not-found',
        );
      case 'cancelled':
        return FirebaseFailure(
          errorMessage: 'Operation was cancelled.',
          code: 'cancelled',
        );
      case 'already-exists':
        return FirebaseFailure(
          errorMessage: 'Resource already exists.',
          code: 'already-exists',
        );
      case 'invalid-argument':
        return FirebaseFailure(
          errorMessage: 'Invalid argument provided.',
          code: 'invalid-argument',
        );
      case 'deadline-exceeded':
        return FirebaseFailure(
          errorMessage: 'Request timed out. Try again.',
          code: 'deadline-exceeded',
        );
      case 'data-loss':
        return FirebaseFailure(
          errorMessage: 'Data loss detected.',
          code: 'data-loss',
        );
      case 'resource-exhausted':
        return FirebaseFailure(
          errorMessage: 'Resource limit exceeded.',
          code: 'resource-exhausted',
        );
      case 'internal':
        return FirebaseFailure(
          errorMessage: 'Internal server error.',
          code: 'internal',
        );

      default:
        return FirebaseFailure(
          errorMessage:
              exception.message ?? 'Unexpected Firebase error occurred.',
          code: exception.code,
        );
    }
  }
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
