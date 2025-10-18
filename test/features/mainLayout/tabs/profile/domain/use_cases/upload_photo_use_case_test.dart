import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'upload_photo_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late UploadPhotoUseCase useCase;
  late MockProfileRepo mockProfileRepo;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiSuccessResult(
        data: UploadPhotoResponseEntity(
          message: '',
        ),
      ),
    );
  });

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    useCase = UploadPhotoUseCase(profileRepo: mockProfileRepo);
  });

  group('UploadPhotoUseCase', () {
    test('should call repository uploadProfilePhoto and return success result', () async {
      // Arrange
      final imageFile = File('test_image.jpg');
      final responseEntity = UploadPhotoResponseEntity(
        message: 'Photo uploaded successfully',

      );

      final successResult = ApiSuccessResult<UploadPhotoResponseEntity>(data: responseEntity);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
      expect((result as ApiSuccessResult).data, responseEntity);

      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should call repository uploadProfilePhoto and return error result when upload fails', () async {
      // Arrange
      final imageFile = File('test_image.jpg');
      final failure = Failure(errorMessage: 'Failed to upload photo');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, failure);
      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should return network failure when there is no internet connection', () async {
      // Arrange
      final imageFile = File('profile_photo.png');
      final failure = Failure(errorMessage: 'No internet connection');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());
      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should return validation failure when file is invalid', () async {
      // Arrange
      final imageFile = File('invalid_file.txt');
      final failure = Failure(errorMessage: 'Invalid file format. Only images are allowed.');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());
      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should return error when file size exceeds limit', () async {
      // Arrange
      final imageFile = File('large_image.jpg');
      final failure = Failure(errorMessage: 'File size exceeds maximum limit of 5MB');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());
      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should pass correct file parameter to repository', () async {
      // Arrange
      final imageFile = File('my_photo.jpg');
      final responseEntity = UploadPhotoResponseEntity(
        message: 'Success',
      );

      final successResult = ApiSuccessResult<UploadPhotoResponseEntity>(data: responseEntity);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => successResult);

      // Act
      await useCase.invoke(imageFile);

      // Assert
      final captured = verify(mockProfileRepo.uploadProfilePhoto(captureAny)).captured;
      expect(captured.length, 1);
      final capturedFile = captured[0] as File;
      expect(capturedFile.path, 'my_photo.jpg');
    });

    test('should handle different image file extensions', () async {
      // Arrange
      final pngFile = File('photo.png');
      final responseEntity = UploadPhotoResponseEntity(
        message: 'PNG uploaded',
      );

      final successResult = ApiSuccessResult<UploadPhotoResponseEntity>(data: responseEntity);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => successResult);

      // Act
      final result = await useCase.invoke(pngFile);

      // Assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
      verify(mockProfileRepo.uploadProfilePhoto(pngFile)).called(1);
    });

    test('should return unauthorized failure when user is not authenticated', () async {
      // Arrange
      final imageFile = File('profile.jpg');
      final failure = Failure(errorMessage: 'User not authenticated');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());

      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should handle timeout failure during upload', () async {
      // Arrange
      final imageFile = File('large_photo.jpg');
      final failure = Failure(errorMessage: 'Upload request timed out');
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(failure: failure);

      when(mockProfileRepo.uploadProfilePhoto(any))
          .thenAnswer((_) async => errorResult);

      // Act
      final result = await useCase.invoke(imageFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      expect((result as ApiErrorResult).failure, isA<Failure>());
      verify(mockProfileRepo.uploadProfilePhoto(imageFile)).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });
  });
}