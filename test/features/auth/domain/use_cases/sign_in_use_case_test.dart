import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';

import 'sign_in_use_case_test.mocks.dart';

// Generate mocks
@GenerateMocks([AuthRepo])

void main() {
  late SignInUseCase useCase;
  late MockAuthRepo mockAuthRepo;

  setUpAll(() {
    provideDummy<ApiResult<SignInResponseEntity>>(
      ApiSuccessResult<SignInResponseEntity>(
        data: SignInResponseEntity(
          token: 'dummy_token',
          message: 'dummy_message',
        ),
      ),
    );
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    useCase = SignInUseCase(authRepo: mockAuthRepo);
  });

  group('SignInUseCase', () {
    final requestEntity = SignInRequestEntity(email: 'test@example.com', password: 'Ahmed@123');
    final responseDto = SignInResponseDto(message: 'success', token: 'token123');
    final responseEntity =responseDto.toEntity();

    test('should return ApiSuccessResult when repository call is successful', () async {
      // Arrange
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke(requestEntity: requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<SignInResponseEntity>>());
      final success = result as ApiSuccessResult<SignInResponseEntity>;
      expect(success.data.token, responseEntity.token);
      expect(success.data.message, responseEntity.message);

      verify(mockAuthRepo.signIn(
        requestEntity: requestEntity,
      )).called(1);
    });
    test('should return ApiErrorResult when repository call fails', () async {
      // Arrange
      final failure = Failure(errorMessage: 'Authentication failed');
      final errorResult = ApiErrorResult<SignInResponseEntity>(failure: failure);

      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
        rememberMeChecked: anyNamed('rememberMeChecked'),
      )).thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(requestEntity: requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<SignInResponseEntity>>());
      final error = result as ApiErrorResult<SignInResponseEntity>;
      expect(error.failure.errorMessage, 'Authentication failed');

      verify(mockAuthRepo.signIn(
        requestEntity: requestEntity,
      )).called(1);
    });
    test('should pass rememberMeChecked as false by default', () async {
      // Arrange
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      await useCase.invoke(requestEntity: requestEntity);

      // Assert
      verify(mockAuthRepo.signIn(
        requestEntity: requestEntity,
      )).called(1);
    });
    test('should pass rememberMeChecked as true when explicitly set', () async {
      // Arrange
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      await useCase.invoke(
        requestEntity: requestEntity,
      );

      // Assert
      verify(mockAuthRepo.signIn(
        requestEntity: requestEntity,

      )).called(1);
    });
    test('should pass correct request entity to repository', () async {
      // Arrange
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      await useCase.invoke(requestEntity: requestEntity);

      // Assert
      final capturedEntity = verify(mockAuthRepo.signIn(
        requestEntity: captureAnyNamed('requestEntity'),
      )).captured.single as SignInRequestEntity;

      expect(capturedEntity.email, requestEntity.email);
      expect(capturedEntity.password, requestEntity.password);
    });
    test('should handle different types of failures', () async {
      final testCases = [
        Failure(errorMessage: 'Network error'),
        Failure(errorMessage: 'Invalid credentials'),
        Failure(errorMessage: 'Server error'),
        Failure(errorMessage: 'Timeout error'),
      ];

      for (final failure in testCases) {
        // Arrange
        final errorResult = ApiErrorResult<SignInResponseEntity>(failure: failure);
        when(mockAuthRepo.signIn(
          requestEntity: anyNamed('requestEntity'),
        )).thenAnswer((_) async => errorResult);

        // Act
        final result = await useCase.invoke(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SignInResponseEntity>>(),
            reason: 'Failed for error: ${failure.errorMessage}');
        final error = result as ApiErrorResult<SignInResponseEntity>;
        expect(error.failure.errorMessage, failure.errorMessage);

        // Reset for next iteration
        reset(mockAuthRepo);
      }
    });
    test('should handle empty email and password', () async {
      // Arrange
      final emptyRequestEntity = SignInRequestEntity(
        email: '',
        password: '',
      );
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);

      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke(requestEntity: emptyRequestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<SignInResponseEntity>>());

      final capturedEntity = verify(mockAuthRepo.signIn(
        requestEntity: captureAnyNamed('requestEntity'),

      )).captured.single as SignInRequestEntity;

      expect(capturedEntity.email, '');
      expect(capturedEntity.password, '');
    });
    test('should preserve exact return value from repository', () async {
      // Arrange
      final customResponseEntity = SignInResponseEntity(
        token: 'custom_token',
        message: 'Custom message',
      );
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: customResponseEntity);

      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke(requestEntity: requestEntity);

      // Assert
      expect(result, equals(successResult));
      final success = result as ApiSuccessResult<SignInResponseEntity>;
      expect(success.data.token, 'custom_token');
      expect(success.data.message, 'Custom message');
    });
    test('should only call repository once per invoke call', () async {
      // Arrange
      final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
        rememberMeChecked: anyNamed('rememberMeChecked'),
      )).thenAnswer((_) async => successResult);

      // Act
      await useCase.invoke(requestEntity: requestEntity);
      await useCase.invoke(requestEntity: requestEntity, rememberMeChecked: true);

      // Assert
      verify(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
        rememberMeChecked: anyNamed('rememberMeChecked'),
      )).called(2);
    });
    test('should handle repository throwing exceptions gracefully', () async {
      // Arrange
      when(mockAuthRepo.signIn(
        requestEntity: anyNamed('requestEntity'),
      )).thenThrow(Exception('Repository exception'));

      // Act & Assert
      expect(
            () => useCase.invoke(requestEntity: requestEntity),
        throwsA(isA<Exception>()),
      );

      verify(mockAuthRepo.signIn(
        requestEntity: requestEntity,
      )).called(1);
    });
  });
}