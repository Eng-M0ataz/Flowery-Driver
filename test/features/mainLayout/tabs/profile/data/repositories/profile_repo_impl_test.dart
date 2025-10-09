import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/repositories/profile_repo_impl.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_driver_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepoImpl repository;
  late MockProfileRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<DriverProfileResponseEntity>>(
      ApiSuccessResult(data: DriverProfileResponseEntity(driver: null)),
    );
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiSuccessResult(data: EditProfileResponseEntity(message: '', driver: null)),
    );
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiSuccessResult(data: UploadPhotoResponseEntity(message: '')),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepoImpl(
      profileRemoteDataSource: mockRemoteDataSource,
    );
  });

  group('getLoggedDriverData', () {
    test('should return DriverProfileResponseEntity when remote data source call is successful', () async {
      // Arrange
      final driverEntity = DriverProfileResponseEntity(
        driver: DriverEntity(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '+1234567890',
          photo: 'https://example.com/photo.jpg',
        ),
      );
      final successResult = ApiSuccessResult<DriverProfileResponseEntity>(data: driverEntity);

      when(mockRemoteDataSource.getLoggedDriverData())
          .thenAnswer((_) async => successResult);

      // Act
      final result = await repository.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());
      expect((result as ApiSuccessResult).data, driverEntity);
      verify(mockRemoteDataSource.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ApiErrorResult when remote data source call fails', () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Server error');
      final errorResult = ApiErrorResult<DriverProfileResponseEntity>(failure: failure);

      when(mockRemoteDataSource.getLoggedDriverData())
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await repository.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockRemoteDataSource.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('editProfile', () {
    test('should return EditProfileResponseEntity when remote data source call is successful', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '+1234567890',
      );
      final responseEntity = EditProfileResponseEntity(
        message: 'Profile updated successfully',
        driver: EditDriverEntity(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '+1234567890',
          photo: null,
        ),
      );
      final successResult = ApiSuccessResult<EditProfileResponseEntity>(data: responseEntity);

      when(mockRemoteDataSource.editProfile(any))
          .thenAnswer((_) async => successResult);

      // Act
      final result = await repository.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      expect((result as ApiSuccessResult).data, responseEntity);
      verify(mockRemoteDataSource.editProfile(requestEntity)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ApiErrorResult when remote data source call fails', () async {
      // Arrange
      final requestEntity = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        phone: '+1234567890',
      );
      final failure = Failure(errorMessage: 'Network error');
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(failure: failure);

      when(mockRemoteDataSource.editProfile(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await repository.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockRemoteDataSource.editProfile(requestEntity)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('uploadProfilePhoto', () {
    test('should return UploadPhotoResponseEntity when remote data source call is successful', () async {
      // Arrange
      final imageFile = File('test_image.jpg');
      final responseEntity = UploadPhotoResponseEntity(
        message: 'Photo uploaded successfully',
      );
      final successResult = ApiSuccessResult<UploadPhotoResponseEntity>(data: responseEntity);

      when(mockRemoteDataSource.uploadProfilePhoto(any))
          .thenAnswer((_) async => successResult);

      // Act
      final result = await repository.uploadProfilePhoto(imageFile);

      // Assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
      expect((result as ApiSuccessResult).data, responseEntity);
      verify(mockRemoteDataSource.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ApiErrorResult when remote data source call fails', () async {
      // Arrange
      final imageFile = File('test_image.jpg');
      final failure = ServerFailure(errorMessage: 'Upload failed');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockRemoteDataSource.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await repository.uploadProfilePhoto(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockRemoteDataSource.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}