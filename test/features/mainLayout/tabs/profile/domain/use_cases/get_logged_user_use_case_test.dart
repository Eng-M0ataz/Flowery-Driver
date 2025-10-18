import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_logged_user_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late GetLoggedUserUseCase useCase;
  late MockProfileRepo mockProfileRepo;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<DriverProfileResponseEntity>>(
      ApiSuccessResult(
        data: DriverProfileResponseEntity(
          driver: DriverEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
            photo: '',
            role: '',
            country: '',
            vehicleType: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
            createdAt: '',
          ),
          message: '',
        ),
      ),
    );
  });

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    useCase = GetLoggedUserUseCase(mockProfileRepo);
  });

  group('GetLoggedUserUseCase', () {
    test(
      'should call repository getLoggedDriverData and return success result',
      () async {
        // Arrange
        final driverEntity = DriverEntity(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          phone: '+1234567890',
          photo: 'https://example.com/photo.jpg',
          role: '',
          country: '',
          vehicleType: '',
          vehicleNumber: '',
          vehicleLicense: '',
          nID: '',
          nIDImg: '',
          gender: '',
          createdAt: '',
        );

        final responseEntity = DriverProfileResponseEntity(
          driver: driverEntity,
          message: '',
        );

        final successResult = ApiSuccessResult<DriverProfileResponseEntity>(
          data: responseEntity,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());
        expect((result as ApiSuccessResult).data, responseEntity);
        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );

    test(
      'should call repository getLoggedDriverData and return error result when repository fails',
      () async {
        // Arrange
        final failure = ServerFailure(
          errorMessage: 'Failed to fetch driver data',
        );
        final errorResult = ApiErrorResult<DriverProfileResponseEntity>(
          failure: failure,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => errorResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
        expect((result as ApiErrorResult).failure, failure);

        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );

    test(
      'should return network failure when there is no internet connection',
      () async {
        // Arrange
        final failure = Failure(errorMessage: 'No internet connection');
        final errorResult = ApiErrorResult<DriverProfileResponseEntity>(
          failure: failure,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => errorResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
        expect((result as ApiErrorResult).failure, isA<Failure>());
        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );

    test(
      'should return unauthorized failure when user is not authenticated',
      () async {
        // Arrange
        final failure = Failure(errorMessage: 'User not authenticated');
        final errorResult = ApiErrorResult<DriverProfileResponseEntity>(
          failure: failure,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => errorResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
        expect((result as ApiErrorResult).failure, isA<Failure>());
        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );

    test(
      'should return driver with null photo when photo is not available',
      () async {
        // Arrange
        final driverEntity = DriverEntity(
          id: '456',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane.smith@example.com',
          phone: '+9876543210',
          photo: '',
          role: '',
          country: '',
          vehicleType: '',
          vehicleNumber: '',
          vehicleLicense: '',
          nID: '',
          nIDImg: '',
          gender: '',
          createdAt: '',
        );

        final responseEntity = DriverProfileResponseEntity(
          driver: driverEntity,
          message: '',
        );

        final successResult = ApiSuccessResult<DriverProfileResponseEntity>(
          data: responseEntity,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());
        expect((result as ApiSuccessResult).data.driver?.photo, '');
        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );

    test('should handle empty driver in response entity', () async {
      // Arrange
      final responseEntity = DriverProfileResponseEntity(
        driver: DriverEntity(
          role: '',
          id: '',
          country: '',
          firstName: '',
          lastName: '',
          vehicleType: '',
          vehicleNumber: '',
          vehicleLicense: '',
          nID: '',
          nIDImg: '',
          email: '',
          gender: '',
          phone: '',
          photo: '',
          createdAt: '',
        ),
        message: '',
      );

      final successResult = ApiSuccessResult<DriverProfileResponseEntity>(
        data: responseEntity,
      );

      when(
        mockProfileRepo.getLoggedDriverData(),
      ).thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());

      final resultData = (result as ApiSuccessResult).data;
      expect(resultData.driver?.role, '');
      expect(resultData.driver?.id, '');
      expect(resultData.driver?.country, '');
      expect(resultData.driver?.firstName, '');
      expect(resultData.driver?.lastName, '');
      expect(resultData.driver?.vehicleType, '');
      expect(resultData.driver?.vehicleNumber, '');
      expect(resultData.driver?.vehicleLicense, '');
      expect(resultData.driver?.nID, '');
      expect(resultData.driver?.nIDImg, '');
      expect(resultData.driver?.email, '');
      expect(resultData.driver?.gender, '');
      expect(resultData.driver?.phone, '');
      expect(resultData.driver?.photo, '');
      expect(resultData.driver?.createdAt, '');

      verify(mockProfileRepo.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test(
      'should verify repository method is called with no parameters',
      () async {
        // Arrange
        final responseEntity = DriverProfileResponseEntity(
          driver: DriverEntity(
            id: '789',
            firstName: 'Bob',
            lastName: 'Wilson',
            email: 'bob@example.com',
            phone: '+1122334455',
            photo: '',
            role: '',
            country: '',
            vehicleType: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
            createdAt: '',
          ),
          message: '',
        );

        final successResult = ApiSuccessResult<DriverProfileResponseEntity>(
          data: responseEntity,
        );

        when(
          mockProfileRepo.getLoggedDriverData(),
        ).thenAnswer((_) async => successResult);

        // Act
        await useCase.invoke();

        // Assert
        verify(mockProfileRepo.getLoggedDriverData()).called(1);
        verifyNoMoreInteractions(mockProfileRepo);
      },
    );
  });
}
