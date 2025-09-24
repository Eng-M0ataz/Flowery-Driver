import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/forget_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/reset_password_response_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/forgetPassword/response/verify_reset_code_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiService])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockAuthApiService mockApiService;

  setUp(() {
    mockApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImpl(mockApiService);
  });

  group('AuthRemoteDataSourceImpl', () {
    group('forgetPassword', () {
      test(
        'should return ApiSuccessResult when API call is successful',
        () async {
          // Arrange
          const email = 'test@example.com';
          final requestEntity = ForgetPasswordRequestEntity(email: email);
          final responseDto = ForgetPasswordResponseDto(
            message: 'Password reset email sent',
            info: 'Check your email for reset instructions',
          );
          final expectedEntity = ForgetPasswordResponseEntity(
            message: 'Password reset email sent',
            info: 'Check your email for reset instructions',
          );

          when(
            mockApiService.forgetPassword(any),
          ).thenAnswer((_) async => responseDto);

          // Act
          final result = await dataSource.forgetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          final successResult =
              result as ApiSuccessResult<ForgetPasswordResponseEntity>;
          expect(successResult.data.message, equals(expectedEntity.message));
          expect(successResult.data.info, equals(expectedEntity.info));
          verify(mockApiService.forgetPassword(any)).called(1);
        },
      );

      test('should return ApiErrorResult when API call fails', () async {
        // Arrange
        const email = 'test@example.com';
        final requestEntity = ForgetPasswordRequestEntity(email: email);
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/forgot-password'),
          response: Response(
            requestOptions: RequestOptions(path: '/forgot-password'),
            statusCode: 400,
            data: {'error': 'Invalid email'},
          ),
        );

        when(mockApiService.forgetPassword(any)).thenThrow(dioException);

        // Act
        final result = await dataSource.forgetPassword(requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
        final errorResult =
            result as ApiErrorResult<ForgetPasswordResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        verify(mockApiService.forgetPassword(any)).called(1);
      });
    });

    group('verifyResetCode', () {
      test(
        'should return ApiSuccessResult when API call is successful',
        () async {
          // Arrange
          const resetCode = '123456';
          final requestEntity = VerifyResetCodeRequestEntity(
            resetCode: resetCode,
          );
          final responseDto = VerifyResetCodeResponseDto(status: 'verified');
          final expectedEntity = VerifyResetCodeResponseEntity(
            status: 'verified',
          );

          when(
            mockApiService.verifyResetCode(any),
          ).thenAnswer((_) async => responseDto);

          // Act
          final result = await dataSource.verifyResetCode(requestEntity);

          // Assert
          expect(
            result,
            isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>(),
          );
          final successResult =
              result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
          expect(successResult.data.status, equals(expectedEntity.status));
          verify(mockApiService.verifyResetCode(any)).called(1);
        },
      );

      test('should return ApiErrorResult when API call fails', () async {
        // Arrange
        const resetCode = '123456';
        final requestEntity = VerifyResetCodeRequestEntity(
          resetCode: resetCode,
        );
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/verify-reset-code'),
          response: Response(
            requestOptions: RequestOptions(path: '/verify-reset-code'),
            statusCode: 400,
            data: {'error': 'Invalid code'},
          ),
        );

        when(mockApiService.verifyResetCode(any)).thenThrow(dioException);

        // Act
        final result = await dataSource.verifyResetCode(requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
        final errorResult =
            result as ApiErrorResult<VerifyResetCodeResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        verify(mockApiService.verifyResetCode(any)).called(1);
      });
    });

    group('resetPassword', () {
      test(
        'should return ApiSuccessResult when API call is successful',
        () async {
          // Arrange
          const email = 'test@example.com';
          const newPassword = 'newPassword123';
          final requestEntity = ResetPasswordRequestEntity(
            email: email,
            newPassword: newPassword,
          );
          final responseDto = ResetPasswordResponseDto(
            message: 'Password reset successfully',
            token: 'new_access_token_123',
          );
          final expectedEntity = ResetPasswordResponseEntity(
            message: 'Password reset successfully',
            token: 'new_access_token_123',
          );

          when(
            mockApiService.resetPassword(any),
          ).thenAnswer((_) async => responseDto);

          // Act
          final result = await dataSource.resetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          final successResult =
              result as ApiSuccessResult<ResetPasswordResponseEntity>;
          expect(successResult.data.message, equals(expectedEntity.message));
          expect(successResult.data.token, equals(expectedEntity.token));
          verify(mockApiService.resetPassword(any)).called(1);
        },
      );

      test('should return ApiErrorResult when API call fails', () async {
        // Arrange
        const email = 'test@example.com';
        const newPassword = 'newPassword123';
        final requestEntity = ResetPasswordRequestEntity(
          email: email,
          newPassword: newPassword,
        );
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/reset-password'),
          response: Response(
            requestOptions: RequestOptions(path: '/reset-password'),
            statusCode: 400,
            data: {'error': 'Invalid password format'},
          ),
        );

        when(mockApiService.resetPassword(any)).thenThrow(dioException);

        // Act
        final result = await dataSource.resetPassword(requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
        final errorResult =
            result as ApiErrorResult<ResetPasswordResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        verify(mockApiService.resetPassword(any)).called(1);
      });
    });
  });
}
