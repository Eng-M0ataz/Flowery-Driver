import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/forget_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/reset_password_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/request/verify_reset_code_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:dio/dio.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import '../../api/dataSources/auth_remote_data_source_impl_test.mocks.dart';
import 'auth_repo_impl_test.mocks.dart' hide MockAuthApiService;

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource,AuthApiService,])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late AuthRepoImpl authRepoImpl;
  late MockAuthApiService mockApiService;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUpAll(() {
    // Provide dummy values for all ApiResult types used in the tests
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
    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
    provideDummy<ApiResult<VehicleTypesResponsEntity>>(
      ApiSuccessResult(data: VehicleTypesResponsEntity(vehicles: [])),
    );
  });

  setUp(() {
    mockApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImpl(mockApiService);
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    authRepoImpl = AuthRepoImpl(
      mockAuthRemoteDataSource,
      mockAuthLocalDataSource,
    );
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

  group('AuthRepoImpl', () {
    // --- Forget Password Feature Tests ---
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
            mockAuthRemoteDataSource.forgetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.forgetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
          final successResult =
          result as ApiSuccessResult<ForgetPasswordResponseEntity>;
          expect(successResult.data.message, equals(responseEntity.message));
          expect(successResult.data.info, equals(responseEntity.info));
          verify(
            mockAuthRemoteDataSource.forgetPassword(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
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
            mockAuthRemoteDataSource.forgetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.forgetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
          final errorResult =
          result as ApiErrorResult<ForgetPasswordResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(
            mockAuthRemoteDataSource.forgetPassword(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
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
            mockAuthRemoteDataSource.verifyResetCode(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.verifyResetCode(requestEntity);

          // Assert
          expect(
            result,
            isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>(),
          );
          final successResult =
          result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
          expect(successResult.data.status, equals(responseEntity.status));
          verify(
            mockAuthRemoteDataSource.verifyResetCode(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
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
            mockAuthRemoteDataSource.verifyResetCode(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.verifyResetCode(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
          final errorResult =
          result as ApiErrorResult<VerifyResetCodeResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(
            mockAuthRemoteDataSource.verifyResetCode(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
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
            mockAuthRemoteDataSource.resetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.resetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
          final successResult =
          result as ApiSuccessResult<ResetPasswordResponseEntity>;
          expect(successResult.data.message, equals(responseEntity.message));
          expect(successResult.data.token, equals(responseEntity.token));
          verify(
            mockAuthRemoteDataSource.resetPassword(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
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
            mockAuthRemoteDataSource.resetPassword(any),
          ).thenAnswer((_) async => expectedResult);

          // Act
          final result = await authRepoImpl.resetPassword(requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
          final errorResult =
          result as ApiErrorResult<ResetPasswordResponseEntity>;
          expect(errorResult.failure, equals(failure));
          verify(
            mockAuthRemoteDataSource.resetPassword(requestEntity),
          ).called(1);
          verifyNoMoreInteractions(mockAuthLocalDataSource);
        },
      );
    });

    // --- Sign Up Feature Tests ---
    group('signUp', () {
      final signUpRequest = SignUpRequestModel(
        firstName: 'test',
        lastName: 'user',
        email: 'test@test.com',
        password: 'password',
        phoneNumber: '1234567890',
        country: 'Egypt',
        vehicleType: 'car',
        vehicleNumber: '123',
        nationalId: '12345678901234',
        nationalIdImage: 'path/to/image',
        vehicleLicenseImage: 'path/to/image',
        confirmPassword: 'password',
        gender: 'male',
      );

      test('should call signUp on the remote data source', () async {
        // arrange
        when(
          mockAuthRemoteDataSource.signUp(any),
        ).thenAnswer((_) async => ApiSuccessResult(data: null));
        // act
        await authRepoImpl.signUp(signUpRequest);
        // assert
        verify(mockAuthRemoteDataSource.signUp(signUpRequest));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });

    group('getVehicleTypes', () {
      final vehicleTypes = VehicleTypesResponsEntity(
        vehicles: [VehicleTypeEntity(id: '1', type: 'car')],
      );

      test('should call getVehicleTypes on the remote data source', () async {
        // arrange
        when(
          mockAuthRemoteDataSource.getVehicleTypes(),
        ).thenAnswer((_) async => ApiSuccessResult(data: vehicleTypes));
        // act
        final result = await authRepoImpl.getVehicleTypes();
        // assert
        expect(result, isA<ApiSuccessResult>());
        expect((result as ApiSuccessResult).data, vehicleTypes);
        verify(mockAuthRemoteDataSource.getVehicleTypes());
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });

    group('getVehicleTypesFromLocal', () {
      final vehicleTypes = VehicleTypesResponsEntity(
        vehicles: [VehicleTypeEntity(id: '1', type: 'car')],
      );

      test('should call loadVehicleList on the local data source', () async {
        // arrange
        when(
          mockAuthLocalDataSource.loadVehicleList(),
        ).thenAnswer((_) async => vehicleTypes);
        // act
        final result = await authRepoImpl.getVehicleTypesFromLocal();
        // assert
        expect(result, vehicleTypes);
        verify(mockAuthLocalDataSource.loadVehicleList());
        verifyNoMoreInteractions(mockAuthLocalDataSource);
      });
    });

    // --- General Tests ---
    group('constructor', () {
      test('should initialize with provided dependencies', () {
        // Arrange & Act
        final repo = AuthRepoImpl(
          mockAuthRemoteDataSource,
          mockAuthLocalDataSource,
        );

        // Assert
        expect(repo, isA<AuthRepoImpl>());
      });
    });
  });
}
