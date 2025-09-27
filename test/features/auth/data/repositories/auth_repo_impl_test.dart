import 'package:dio/dio.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';

import '../../api/dataSources/auth_remote_data_source_impl_test.mocks.dart';
import 'auth_repo_impl_test.mocks.dart' hide MockAuthApiService;

// Generate mocks
@GenerateMocks([
  AuthApiService,
])

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockAuthApiService mockApiService;

  setUp(() {
    mockApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImpl(mockApiService);
  });

  group('AuthRemoteDataSourceImpl', () {
    final requestEntity =
    SignInRequestEntity(email: 'test@example.com', password: 'Ahmed@123');
    final responseDto =
    SignInResponseDto(message: 'success', token: 'token123');
    final responseEntity =responseDto.toEntity();

    group('signIn', () {
      test('should return ApiSuccessResult when API call is successful', () async {
        // Arrange
        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenAnswer((_) async => responseDto);


        // Act
        final result = await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiSuccessResult<SignInResponseEntity>>());
        final success = result as ApiSuccessResult<SignInResponseEntity>;
        expect(success.data.token, responseEntity.token);
        expect(success.data.message, responseEntity.message);

        verify(mockApiService.signIn(requestDto: anyNamed('requestDto'))).called(1);
      });

      test('should pass correct email and password to API service', () async {
        // Arrange
        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenAnswer((_) async => responseDto);
        // Act
        await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        final captured = verify(mockApiService.signIn(requestDto: captureAnyNamed('requestDto')))
            .captured.single;
        expect(captured.email, requestEntity.email);
        expect(captured.password, requestEntity.password);
      });

      test('should return ApiErrorResult with ServerFailure when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/signin'),
          type: DioExceptionType.connectionTimeout,
          message: 'Connection timeout',
        );

        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenThrow(dioException);

        // Act
        final result = await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SignInResponseEntity>>());
        final error = result as ApiErrorResult<SignInResponseEntity>;
        expect(error.failure, isA<ServerFailure>());

        verify(mockApiService.signIn(requestDto: anyNamed('requestDto'))).called(1);
      });

      test('should return ApiErrorResult with Failure when generic exception occurs', () async {
        // Arrange
        const errorMessage = 'Something went wrong';
        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SignInResponseEntity>>());
        final error = result as ApiErrorResult<SignInResponseEntity>;
        expect(error.failure, isA<Failure>());
        expect(error.failure.errorMessage, contains(errorMessage));

        verify(mockApiService.signIn(requestDto: anyNamed('requestDto'))).called(1);
      });

      test('should handle different DioException types correctly', () async {
        final testCases = [
          DioExceptionType.connectionTimeout,
          DioExceptionType.receiveTimeout,
          DioExceptionType.sendTimeout,
          DioExceptionType.badResponse,
          DioExceptionType.cancel,
          DioExceptionType.connectionError,
          DioExceptionType.unknown,
        ];

        for (final exceptionType in testCases) {
          // Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/signin'),
            type: exceptionType,
          );

          when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
              .thenThrow(dioException);

          // Act
          final result = await dataSource.signIn(requestEntity: requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<SignInResponseEntity>>(),
              reason: 'Failed for exception type: $exceptionType');
          final error = result as ApiErrorResult<SignInResponseEntity>;
          expect(error.failure, isA<ServerFailure>(),
              reason: 'Failed for exception type: $exceptionType');

          // Reset for next iteration
          reset(mockApiService);
        }
      });

      test('should handle empty email and password', () async {
        // Arrange
        final emptyRequestEntity = SignInRequestEntity(
          email: '',
          password: '',
        );

        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenAnswer((_) async => responseDto);

        // Act
        final result = await dataSource.signIn(requestEntity: emptyRequestEntity);

        // Assert
        expect(result, isA<ApiSuccessResult<SignInResponseEntity>>());

        final captured = verify(mockApiService.signIn(requestDto: captureAnyNamed('requestDto')))
            .captured.single;
        expect(captured.email, '');
        expect(captured.password, '');
      });

      test('should handle null values gracefully', () async {
        // Arrange - This tests the robustness of your implementation
        final errorMessage = 'Null value encountered';
        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenThrow(errorMessage);

        // Act
        final result = await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SignInResponseEntity>>());
        final error = result as ApiErrorResult<SignInResponseEntity>;
        expect(error.failure, isA<Failure>());
        expect(error.failure.errorMessage, errorMessage);
      });

    });
  });
}