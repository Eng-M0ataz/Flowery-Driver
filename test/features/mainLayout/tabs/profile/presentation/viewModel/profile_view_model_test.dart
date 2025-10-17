import 'dart:io';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_response_entity.dart';
import 'package:flutter/material.dart';
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
    ApiSuccessResult(data: DriverProfileResponseEntity(driver: DriverEntity())),
  );
  provideDummy<ApiResult<EditProfileResponseEntity>>(
    ApiSuccessResult(data: EditProfileResponseEntity(message: '')),
  );
  provideDummy<ApiResult<UploadPhotoResponseEntity>>(
    ApiSuccessResult(data: UploadPhotoResponseEntity(message: '')),
  );
}


class _MockFormState extends FormState {
  @override
  bool validate() {
    return true; // Always return true for testing
  }

  @override
  void save() {
    // Do nothing for testing
  }

  @override
  void reset() {
    // Do nothing for testing
  }
}

@GenerateMocks([
  GetLoggedUserUseCase,
  EditProfileUseCase,
  UploadPhotoUseCase,
])
void main() {
  late ProfileViewModel profileViewModel;
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;

  setUpAll(() {
    provideDummyApiResults();
  });

  setUp(() {
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();

    profileViewModel = ProfileViewModel(
      mockGetLoggedUserUseCase,
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
    );
  });

  tearDown(() {
    profileViewModel.close();
  });

  group('ProfileViewModel Tests', () {
    final mockDriverProfileResponse = DriverProfileResponseEntity(
      driver: DriverEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
        photo: 'https://example.com/photo.jpg',
      ),
    );

    group('GetLoggedDriverDataEvent', () {
      test('should load driver data successfully', () async {
        // Arrange
        when(mockGetLoggedUserUseCase()).thenAnswer(
              (_) async => ApiSuccessResult(data: mockDriverProfileResponse),
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
        expect(profileViewModel.state.driverProfileResponseEntity, mockDriverProfileResponse);

        verify(mockGetLoggedUserUseCase()).called(1);
      });

      test('should handle failure when loading driver data', () async {
        // Arrange
        final failure = ServerFailure(errorMessage: 'Failed to load profile');
        when(mockGetLoggedUserUseCase()).thenAnswer(
              (_) async => ApiErrorResult(failure: failure),
        );

        // Act
        await profileViewModel.doIntend(GetLoggedDriverDataEvent());

        // Assert
        expect(profileViewModel.state.failure, equals(failure));
        expect(profileViewModel.state.isLoading, false);

        verify(mockGetLoggedUserUseCase()).called(1);
      });
    });

    group('LoadDriverDataEvent', () {
      test('should load driver data when LoadDriverDataEvent is called', () async {
        // Arrange
        when(mockGetLoggedUserUseCase()).thenAnswer(
              (_) async => ApiSuccessResult(data: mockDriverProfileResponse),
        );

        // Act
        await profileViewModel.doIntend(LoadDriverDataEvent());

        // Assert
        expect(profileViewModel.firstNameController.text, 'John');
        expect(profileViewModel.lastNameController.text, 'Doe');

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