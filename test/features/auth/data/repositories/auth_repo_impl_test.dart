import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  // Provide dummy values for ApiResult types
  provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
    ApiSuccessResult<ForgetPasswordResponseEntity>(
      data: ForgetPasswordResponseEntity(message: '', info: ''),
    ),
  );
  provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
    ApiSuccessResult<VerifyResetCodeResponseEntity>(
      data: VerifyResetCodeResponseEntity(status: ''),
    ),
  );
  provideDummy<ApiResult<ResetPasswordResponseEntity>>(
    ApiSuccessResult<ResetPasswordResponseEntity>(
      data: ResetPasswordResponseEntity(message: '', token: ''),
    ),
  );
  late AuthRepoImpl authRepo;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    authRepo = AuthRepoImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('AuthRepoImpl', () {
    group('forgetPassword', () {
      test(
        'should return ApiSuccessResult when remote data source call is successful',
        () async {
          // Arrange
          const email = 'test@example.com';
          final requestEntity = ForgetPasswordRequestEntity(email: email);
          final responseEntity = ForgetPasswordResponseEntity(
            message: 'Password reset email sent',
            info: 'Check your email for reset instructions',
          );
          final expectedResult = ApiSuccessResult<ForgetPasswordResponseEntity>(
            data: responseEntity,
          );

          when(
            mockRemoteDataSource.forgetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.forgetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          final successResult =
              result as ApiSuccessResult<ForgetPasswordResponseEntity>;
          expect(successResult.data.message, equals(responseEntity.message));
          expect(successResult.data.info, equals(responseEntity.info));
          verify(mockRemoteDataSource.forgetPassword(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );

      test(
        'should return ApiErrorResult when remote data source call fails',
        () async {
          // Arrange
          const email = 'test@example.com';
          final requestEntity = ForgetPasswordRequestEntity(email: email);
          final failure = Failure(errorMessage: 'Network error');
          final expectedResult = ApiErrorResult<ForgetPasswordResponseEntity>(
            failure: failure,
          );

          when(
            mockRemoteDataSource.forgetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.forgetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          final errorResult =
              result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(mockRemoteDataSource.forgetPassword(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });

    group('verifyResetCode', () {
      test(
        'should return ApiSuccessResult when remote data source call is successful',
        () async {
          // Arrange
          const resetCode = '123456';
          final requestEntity = VerifyResetCodeRequestEntity(
            resetCode: resetCode,
          );
          final responseEntity = VerifyResetCodeResponseEntity(
            status: 'verified',
          );
          final expectedResult =
              ApiSuccessResult<VerifyResetCodeResponseEntity>(
                data: responseEntity,
              );

          when(
            mockRemoteDataSource.verifyResetCode(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.verifyResetCode(requestEntity);

          // Assert
          expect(
            result,
            isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>(),
          );
          final successResult =
              result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
          expect(successResult.data.status, equals(responseEntity.status));
          verify(mockRemoteDataSource.verifyResetCode(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );

      test(
        'should return ApiErrorResult when remote data source call fails',
        () async {
          // Arrange
          const resetCode = '123456';
          final requestEntity = VerifyResetCodeRequestEntity(
            resetCode: resetCode,
          );
          final failure = Failure(errorMessage: 'Invalid reset code');
          final expectedResult = ApiErrorResult<VerifyResetCodeResponseEntity>(
            failure: failure,
          );

          when(
            mockRemoteDataSource.verifyResetCode(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.verifyResetCode(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
          final errorResult =
              result as ApiErrorResult<VerifyResetCodeResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(mockRemoteDataSource.verifyResetCode(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });

    group('resetPassword', () {
      test(
        'should return ApiSuccessResult when remote data source call is successful',
        () async {
          // Arrange
          const email = 'test@example.com';
          const newPassword = 'newPassword123';
          final requestEntity = ResetPasswordRequestEntity(
            email: email,
            newPassword: newPassword,
          );
          final responseEntity = ResetPasswordResponseEntity(
            message: 'Password reset successfully',
            token: 'new_access_token_123',
          );
          final expectedResult = ApiSuccessResult<ResetPasswordResponseEntity>(
            data: responseEntity,
          );

          when(
            mockRemoteDataSource.resetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.resetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          final successResult =
              result as ApiSuccessResult<ResetPasswordResponseEntity>;
          expect(successResult.data.message, equals(responseEntity.message));
          expect(successResult.data.token, equals(responseEntity.token));
          verify(mockRemoteDataSource.resetPassword(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );

      test(
        'should return ApiErrorResult when remote data source call fails',
        () async {
          // Arrange
          const email = 'test@example.com';
          const newPassword = 'newPassword123';
          final requestEntity = ResetPasswordRequestEntity(
            email: email,
            newPassword: newPassword,
          );
          final failure = Failure(errorMessage: 'Password reset failed');
          final expectedResult = ApiErrorResult<ResetPasswordResponseEntity>(
            failure: failure,
          );

          when(
            mockRemoteDataSource.resetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepo.resetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
          final errorResult =
              result as ApiErrorResult<ResetPasswordResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(mockRemoteDataSource.resetPassword(requestEntity)).called(1);
          verifyNoMoreInteractions(mockLocalDataSource);
        },
      );
    });

    group('constructor', () {
      test('should initialize with provided dependencies', () {
        // Arrange & Act
        final repo = AuthRepoImpl(mockRemoteDataSource, mockLocalDataSource);

        // Assert
        expect(repo, isA<AuthRepoImpl>());
      });
    });
  });
}
