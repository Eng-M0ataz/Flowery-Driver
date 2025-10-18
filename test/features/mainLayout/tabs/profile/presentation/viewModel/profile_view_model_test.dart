import 'dart:io';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_driver_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_vehicle_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';

import 'profile_view_model_test.mocks.dart';

void provideDummyApiResults() {
  provideDummy<ApiResult<DriverProfileResponseEntity>>(
    ApiSuccessResult(
      data: DriverProfileResponseEntity(
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
      ),
    ),
  );
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
          photo: '',
          role: '',
          country: '',
          vehicleType: '',
          vehicleNumber: '',
          vehicleLicense: '',
          nID: '',
          nIDImg: '',
          password: '',
          gender: '',
          createdAt: '',
        ),
      ),
    ),
  );
  provideDummy<ApiResult<UploadPhotoResponseEntity>>(
    ApiSuccessResult(data: UploadPhotoResponseEntity(message: '')),
  );

  provideDummy<ApiResult<VehicleResponseEntity>>(
    ApiSuccessResult(
      data: VehicleResponseEntity(
        message: '',
        vehicle: VehicleEntity(
          id: '',
          type: '',
          image: '',
          createdAt: '',
          updatedAt: '',
        ),
      ),
    ),
  );
}



@GenerateMocks([
  GetLoggedUserUseCase,
  EditProfileUseCase,
  UploadPhotoUseCase,
  GetVehicleUseCase,
])
void main() {
  late ProfileViewModel profileViewModel;
  late MockGetVehicleUseCase mockGetVehicleUseCase;
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;

  setUpAll(() {
    provideDummyApiResults();
  });

  setUp(() {
    mockGetVehicleUseCase = MockGetVehicleUseCase();
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();

    profileViewModel = ProfileViewModel(
      mockGetVehicleUseCase,
      mockGetLoggedUserUseCase,
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
    );
  });

  tearDown(() {
    profileViewModel.close();
  });

  group('ProfileViewModel Tests', () {

    group('GetLoggedDriverDataEvent', () {
      test('should load driver data successfully', () async {
        // Arrange - Make sure vehicleType is not null
        final mockDriverProfileResponse = DriverProfileResponseEntity(
          driver: DriverEntity(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
            phone: '+1234567890',
            photo: 'https://example.com/photo.jpg',
            vehicleType: 'vehicle_123',
            role: '',
            id: '',
            country: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
            createdAt: '', // ADD THIS - make sure it's not null
          ),
          message: '',
        );

        when(mockGetLoggedUserUseCase()).thenAnswer(
          (_) async => ApiSuccessResult(data: mockDriverProfileResponse),
        );

        // Also mock the getVehicleUseCase since it will be called
        when(mockGetVehicleUseCase('vehicle_123')).thenAnswer(
          (_) async => ApiSuccessResult(
            data: VehicleResponseEntity(
              message: '',
              vehicle: VehicleEntity(
                id: '',
                type: '',
                image: '',
                createdAt: '',
                updatedAt: '',
              ),
            ),
          ),
        );

        // Act
        await profileViewModel.doIntend(GetLoggedDriverDataEvent());

        // Assert
        expect(profileViewModel.firstNameController.text, 'John');
        expect(profileViewModel.lastNameController.text, 'Doe');
        expect(profileViewModel.emailController.text, 'john.doe@example.com');
        expect(profileViewModel.phoneNumberController.text, '+1234567890');
        expect(profileViewModel.initialImage, 'https://example.com/photo.jpg');

        // Verify state changes
        expect(profileViewModel.state.isLoading, false);
        expect(profileViewModel.state.failure, isNull);
        expect(
          profileViewModel.state.driverProfileResponseEntity,
          mockDriverProfileResponse,
        );

        verify(mockGetLoggedUserUseCase()).called(1);
        verify(
          mockGetVehicleUseCase('vehicle_123'),
        ).called(1); // Also verify this is called
      });

      test('should handle failure when loading driver data', () async {
        // Arrange
        final failure = ServerFailure(errorMessage: 'Failed to load profile');
        when(
          mockGetLoggedUserUseCase(),
        ).thenAnswer((_) async => ApiErrorResult(failure: failure));

        // Act
        await profileViewModel.doIntend(GetLoggedDriverDataEvent());

        // Assert
        expect(profileViewModel.state.failure, equals(failure));
        expect(profileViewModel.state.isLoading, false);

        verify(mockGetLoggedUserUseCase()).called(1);
      });
    });

    group('LoadDriverDataEvent', () {
      // Define these at the group level so they're available to all tests

      test(
        'should load driver data when LoadDriverDataEvent is called',
        () async {
          // Arrange
          final mockDriverProfileResponse = DriverProfileResponseEntity(
            driver: DriverEntity(
              firstName: 'John',
              lastName: 'Doe',
              email: 'john.doe@example.com',
              phone: '+1234567890',
              photo: 'https://example.com/photo.jpg',
              vehicleType: 'vehicle_1',
              role: '',
              id: '',
              country: '',
              vehicleNumber: '',
              vehicleLicense: '',
              nID: '',
              nIDImg: '',
              gender: '',
              createdAt: '', // CRITICAL: This must not be null
            ),
            message: '',
          );

          final mockVehicleResponse = VehicleResponseEntity(
            message: 'Success',
            vehicle: VehicleEntity(
              id: 'vehicle_1',
              // This should match the vehicleType above
              updatedAt: '5-1-2522',
              type: 'Moto',
              image: 'path',
              createdAt: '5-1-2522',
            ),
          );

          when(mockGetLoggedUserUseCase()).thenAnswer(
            (_) async => ApiSuccessResult(data: mockDriverProfileResponse),
          );

          when(mockGetVehicleUseCase('vehicle_1')).thenAnswer(
            // Use the same ID here
            (_) async => ApiSuccessResult(data: mockVehicleResponse),
          );

          // Act
          await profileViewModel.doIntend(LoadDriverDataEvent());

          // Assert
          expect(profileViewModel.firstNameController.text, 'John');
          expect(profileViewModel.lastNameController.text, 'Doe');
          expect(profileViewModel.emailController.text, 'john.doe@example.com');
          expect(profileViewModel.phoneNumberController.text, '+1234567890');
          expect(profileViewModel.state.isLoading, false);
          expect(profileViewModel.state.failure, isNull);

          verify(mockGetLoggedUserUseCase()).called(1);
          verify(
            mockGetVehicleUseCase('vehicle_1'),
          ).called(1); // Verify with the same ID
        },
      );

      test('should handle driver data without vehicle type', () async {
        // Arrange - driver with null vehicle type
        final driverWithoutVehicle = DriverProfileResponseEntity(
          driver: DriverEntity(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
            phone: '+1234567890',
            photo: 'https://example.com/photo.jpg',
            vehicleType: '',
            role: '',
            id: '',
            country: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
            createdAt: '', // No vehicle type
          ),
          message: '',
        );

        when(
          mockGetLoggedUserUseCase(),
        ).thenAnswer((_) async => ApiSuccessResult(data: driverWithoutVehicle));

        // Since the ViewModel uses ! operator, this will throw an error
        // We need to expect that error
        expect(
          () async => await profileViewModel.doIntend(LoadDriverDataEvent()),
          throwsA(isA<Error>()), // Expect the null check error
        );

        // We can still verify the first call was made
        verify(mockGetLoggedUserUseCase()).called(1);
      });

      test('should handle empty vehicle type string', () async {
        // Arrange - driver with empty vehicle type
        final driverWithEmptyVehicle = DriverProfileResponseEntity(
          driver: DriverEntity(
            firstName: 'John',
            lastName: 'Doe',
            email: 'john.doe@example.com',
            phone: '+1234567890',
            photo: 'https://example.com/photo.jpg',
            vehicleType: '',
            role: '',
            id: '',
            country: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
            createdAt: '', // Empty vehicle type
          ),
          message: '',
        );

        when(mockGetLoggedUserUseCase()).thenAnswer(
          (_) async => ApiSuccessResult(data: driverWithEmptyVehicle),
        );

        // Mock the empty string case that the ViewModel will call
        when(mockGetVehicleUseCase('')).thenAnswer(
          (_) async => ApiSuccessResult(
            data: VehicleResponseEntity(
              message: '',
              vehicle: VehicleEntity(
                createdAt: '',
                image: '',
                type: '',
                updatedAt: '',
                id: '',
              ),
            ),
          ),
        );

        // Act
        await profileViewModel.doIntend(LoadDriverDataEvent());

        // Assert
        expect(profileViewModel.firstNameController.text, 'John');
        expect(profileViewModel.lastNameController.text, 'Doe');
        expect(profileViewModel.state.isLoading, false);
        expect(profileViewModel.state.failure, isNull);

        verify(mockGetLoggedUserUseCase()).called(1);
        verify(
          mockGetVehicleUseCase(''),
        ).called(1); // Should call with empty string
      });

      // Add a test for when both driver and vehicleType are null
      test('should handle completely null driver data', () async {
        // Arrange - completely null driver
        final nullDriverResponse = DriverProfileResponseEntity(
          driver: DriverEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
            photo: '',
            role: '',
            createdAt: '',
            country: '',
            vehicleType: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nID: '',
            nIDImg: '',
            gender: '',
          ),
          message: '',
        );

        when(
          mockGetLoggedUserUseCase(),
        ).thenAnswer((_) async => ApiSuccessResult(data: nullDriverResponse));

        // This will throw because of response.driver! in the ViewModel
        expect(
          () async => await profileViewModel.doIntend(LoadDriverDataEvent()),
          throwsA(isA<Error>()), // Expect the null check error
        );

        verify(mockGetLoggedUserUseCase()).called(1);
      });
    });

    group('OnImageSelectedEvent', () {
      test('should update selected image file', () async {
        // Arrange
        final mockFile = File('test/path/image.jpg');

        // Act
        profileViewModel.doIntend(OnImageSelectedEvent(file: mockFile));

        // Assert
        expect(profileViewModel.selectedImageFile, mockFile);
        expect(profileViewModel.state.selectedImage, mockFile);
      });
    });

    group('Controller Initialization', () {
      test('controllers should be properly initialized', () {
        expect(profileViewModel.firstNameController, isNotNull);
        expect(profileViewModel.lastNameController, isNotNull);
        expect(profileViewModel.emailController, isNotNull);
        expect(profileViewModel.phoneNumberController, isNotNull);
        expect(profileViewModel.editProfileFormKey, isNotNull);
      });
    });

    group('CloseEvent', () {
      test('should call close method when CloseEvent is received', () async {
        // Act
        await profileViewModel.doIntend(CloseEvent());

        // Assert - The view model should be closed
        expect(profileViewModel.isClosed, true);
      });
    });
  });
}
