import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_driver_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late EditProfileUseCase useCase;
  late MockProfileRepo mockProfileRepo;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiSuccessResult(
        data: EditProfileResponseEntity(
          message: '',
          driver: EditDriverEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
            photo: '', role: '', country: '', vehicleType: '', vehicleNumber: '', vehicleLicense: '', nID: '', nIDImg: '', password: '', gender: '', createdAt: '',
          ),
        ),
      ),
    );
  });

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    useCase = EditProfileUseCase(profileRepo: mockProfileRepo);
  });

  group('EditProfileUseCase', () {
    test('should call repository editProfile and return success result', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890', gender: '',
      );

      final driverEntity = EditDriverEntity(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        photo: 'https://example.com/photo.jpg', role: '', country: '', vehicleType: '', vehicleNumber: '', vehicleLicense: '', nID: '', nIDImg: '', password: '', gender: '', createdAt: '',
      );

      final responseEntity = EditProfileResponseEntity(
        message: 'Profile updated successfully',
        driver: driverEntity,
      );

      final successResult = ApiSuccessResult<EditProfileResponseEntity>(data: responseEntity);

      when(mockProfileRepo.editProfile(any))
          .thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.call(requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      expect((result as ApiSuccessResult).data, responseEntity);
      verify(mockProfileRepo.editProfile(requestEntity)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should call repository editProfile and return error result when repository fails', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890', gender: '',
      );

      final failure = ServerFailure(errorMessage: 'Failed to update profile');
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(failure: failure);

      when(mockProfileRepo.editProfile(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.call(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockProfileRepo.editProfile(requestEntity)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should call repository editProfile and return network failure', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane.smith@example.com',
        phone: '+9876543210', gender: '',
      );

      final failure = Failure(errorMessage: 'No internet connection');
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(failure: failure);

      when(mockProfileRepo.editProfile(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.call(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockProfileRepo.editProfile(requestEntity)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should pass correct request entity to repository', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'Alice',
        lastName: 'Johnson',
        email: 'alice@example.com',
        phone: '+1122334455', gender: '',
      );

      final responseEntity = EditProfileResponseEntity(
        message: 'Success',
        driver: EditDriverEntity(
          id: '456',
          firstName: 'Alice',
          lastName: 'Johnson',
          email: 'alice@example.com',
          phone: '+1122334455',
          photo: '', role: '', country: '', vehicleType: '', vehicleNumber: '', vehicleLicense: '', nID: '', nIDImg: '', password: '', gender: '', createdAt: '',
        ),
      );

      final successResult = ApiSuccessResult<EditProfileResponseEntity>(data: responseEntity);

      when(mockProfileRepo.editProfile(any))
          .thenAnswer((_) async => successResult);

      // Act
      await useCase.call(requestEntity);

      // Assert
      final captured = verify(mockProfileRepo.editProfile(captureAny)).captured;
      expect(captured.length, 1);
      final capturedRequest = captured[0] as EditProfileRequestEntity;
      expect(capturedRequest.firstName, 'Alice');
      expect(capturedRequest.lastName, 'Johnson');
      expect(capturedRequest.email, 'alice@example.com');
      expect(capturedRequest.phone, '+1122334455');
    });

    test('should handle validation failure from repository', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: '',
        lastName: '',
        email: 'invalid-email',
        phone: '', gender: '',
      );

      final failure = Failure(errorMessage: 'Invalid input data');
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(failure: failure);

      when(mockProfileRepo.editProfile(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.call(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());
      verify(mockProfileRepo.editProfile(requestEntity)).called(1);
    });
  });
}