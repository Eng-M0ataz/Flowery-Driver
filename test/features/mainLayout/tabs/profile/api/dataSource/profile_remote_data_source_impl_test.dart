import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/dataSource/profile_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/requestes/edit_profile_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/driver_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/edit_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/responses/upload_photo_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks by running: dart run build_runner build
@GenerateMocks([
  ProfileApiService,
  DriverProfileResponseDto,
  EditProfileResponseDto,
  UploadPhotoResponseDto,
  EditProfileRequestModel,
])
import 'profile_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockProfileApiService mockProfileApiService;
  late ProfileRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockProfileApiService = MockProfileApiService();
    remoteDataSource = ProfileRemoteDataSourceImpl(
      profileApiService: mockProfileApiService,
    );
  });

  group('ProfileRemoteDataSourceImpl - getLoggedDriverData', () {
    test('should return ApiSuccessResult with mapped entity when API call succeeds', () async {
      // Arrange
      final mockDriverDto = DriverDto(
        Id: '1',
        firstName: 'Ahmed',
        lastName: 'Hassan',
        email: 'ahmed@example.com',
        phone: '+201234567890',
        photo: 'https://example.com/photo.jpg',
      );

      final mockDto = DriverProfileResponseDto(
        message: 'Data retrieved successfully',
        driver: mockDriverDto,
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenAnswer((_) async => mockDto);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());
      final successResult = result as ApiSuccessResult<DriverProfileResponseEntity>;
      expect(successResult.data.driver?.firstName, equals('Ahmed'));
      expect(successResult.data.driver?.email, equals('ahmed@example.com'));

      verify(mockProfileApiService.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockProfileApiService);
    });

    test('should return ApiErrorResult when API throws DioException with 401 Unauthorized', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/driver'),
        response: Response(
          requestOptions: RequestOptions(path: '/driver'),
          statusCode: 401,
          statusMessage: 'Unauthorized',
          data: {'message': 'Token expired'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      final errorResult = result as ApiErrorResult<DriverProfileResponseEntity>;
      expect(errorResult.failure, isNotNull);

      verify(mockProfileApiService.getLoggedDriverData()).called(1);
      verifyNoMoreInteractions(mockProfileApiService);
    });

    test('should return ApiErrorResult when API throws DioException with 500 Server Error', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/driver'),
        response: Response(
          requestOptions: RequestOptions(path: '/driver'),
          statusCode: 500,
          statusMessage: 'Internal Server Error',
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      verify(mockProfileApiService.getLoggedDriverData()).called(1);
    });

    test('should return ApiErrorResult when API throws connection timeout', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/driver'),
        type: DioExceptionType.connectionTimeout,
        message: 'Connection timeout',
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      verify(mockProfileApiService.getLoggedDriverData()).called(1);
    });

    test('should return ApiErrorResult when API throws network error', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/driver'),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      verify(mockProfileApiService.getLoggedDriverData()).called(1);
    });

    test('should return ApiErrorResult when API throws 404 Not Found', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/driver'),
        response: Response(
          requestOptions: RequestOptions(path: '/driver'),
          statusCode: 404,
          statusMessage: 'Not Found',
          data: {'message': 'Driver not found'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      verify(mockProfileApiService.getLoggedDriverData()).called(1);
    });

    test('should return ApiErrorResult when API throws generic exception', () async {
      // Arrange
      when(mockProfileApiService.getLoggedDriverData())
          .thenThrow(Exception('Unexpected error'));

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiErrorResult<DriverProfileResponseEntity>>());
      verify(mockProfileApiService.getLoggedDriverData()).called(1);
    });
  });

  group('ProfileRemoteDataSourceImpl - editProfile', () {
    late EditProfileRequestEntity requestEntity;

    setUp(() {
      requestEntity = EditProfileRequestEntity(
        firstName: 'Mohamed',
        lastName: 'Ali',
        email: 'mohamed@example.com',
        phone: '+201098765432',
      );
    });

    test('should call API service with correctly mapped EditProfileRequestModel', () async {
      // Arrange
      final mockDto = EditProfileResponseDto(
        message: 'Profile updated',
      );

      when(mockProfileApiService.editProfile(any))
          .thenAnswer((_) async => mockDto);

      // Act
      await remoteDataSource.editProfile(requestEntity);

      // Assert
      final captured = verify(
        mockProfileApiService.editProfile(captureAny),
      ).captured;

      expect(captured.length, 1);
      final capturedModel = captured[0] as EditProfileRequestModel;
      expect(capturedModel.firstName, equals('Mohamed'));
      expect(capturedModel.lastName, equals('Ali'));
      expect(capturedModel.email, equals('mohamed@example.com'));
      expect(capturedModel.phone, equals('+201098765432'));
    });

    test('should return ApiErrorResult when validation fails (400)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        response: Response(
          requestOptions: RequestOptions(path: '/profile/edit'),
          statusCode: 400,
          statusMessage: 'Bad Request',
          data: {
            'error': 'Validation Error',
            'errors': {
              'email': ['Invalid email format'],
              'firstName': ['First name is required']
            }
          },
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });

    test('should return ApiErrorResult when email already exists (409)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        response: Response(
          requestOptions: RequestOptions(path: '/profile/edit'),
          statusCode: 409,
          statusMessage: 'Conflict',
          data: {'message': 'Email already registered to another account'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });

    test('should return ApiErrorResult on server error (500)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        response: Response(
          requestOptions: RequestOptions(path: '/profile/edit'),
          statusCode: 500,
          statusMessage: 'Internal Server Error',
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });

    test('should return ApiErrorResult on network connection error', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        type: DioExceptionType.connectionError,
        message: 'Failed to connect to server',
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });

    test('should return ApiErrorResult on request cancellation', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        type: DioExceptionType.cancel,
        message: 'Request cancelled',
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });

    test('should return ApiErrorResult when unauthorized (401)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/profile/edit'),
        response: Response(
          requestOptions: RequestOptions(path: '/profile/edit'),
          statusCode: 401,
          statusMessage: 'Unauthorized',
          data: {'message': 'Unauthorized access'}, // 👈 Add this line
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.editProfile(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
      verify(mockProfileApiService.editProfile(any)).called(1);
    });
  });

  group('ProfileRemoteDataSourceImpl - uploadProfilePhoto', () {
    late File mockFile;

    setUp(() {
      mockFile = File('test_assets/test_photo.jpg');
    });

    test('should return ApiSuccessResult with photo URL when upload succeeds', () async {
      // Arrange
      final mockDto = UploadPhotoResponseDto(
        message: 'Photo uploaded successfully',
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenAnswer((_) async => mockDto);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
      final successResult = result as ApiSuccessResult<UploadPhotoResponseEntity>;

      expect(successResult.data.message, equals('Photo uploaded successfully'));


      verify(mockProfileApiService.uploadProfilePhoto(mockFile)).called(1);
      verifyNoMoreInteractions(mockProfileApiService);
    });

    test('should pass correct file to API service', () async {
      // Arrange
      final testFile = File('test_photo_123.jpg');
      final mockDto = UploadPhotoResponseDto(

        message: 'Uploaded',

      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenAnswer((_) async => mockDto);

      // Act
      await remoteDataSource.uploadProfilePhoto(testFile);

      // Assert
      verify(mockProfileApiService.uploadProfilePhoto(testFile)).called(1);
    });

    test('should return ApiErrorResult when file size exceeds limit (413)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        response: Response(
          requestOptions: RequestOptions(path: '/upload'),
          statusCode: 413,
          statusMessage: 'Payload Too Large',
          data: {'message': 'File size exceeds maximum allowed size of 5MB'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult when file type is invalid (415)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        response: Response(
          requestOptions: RequestOptions(path: '/upload'),
          statusCode: 415,
          statusMessage: 'Unsupported Media Type',
          data: {'message': 'Only JPG, JPEG, PNG files are allowed'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult on upload timeout', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        type: DioExceptionType.receiveTimeout,
        message: 'Upload took too long',
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult on server error (500)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        response: Response(
          requestOptions: RequestOptions(path: '/upload'),
          statusCode: 500,
          statusMessage: 'Internal Server Error',
          data: {'message': 'Failed to process image'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult when unauthorized (401)', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        response: Response(
          requestOptions: RequestOptions(path: '/upload'),
          statusCode: 401,
          statusMessage: 'Unauthorized',
          data: {'message': 'Authentication required'},
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult on network connection error', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/upload'),
        type: DioExceptionType.connectionError,
        message: 'No internet connection',
      );

      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(dioException);

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });

    test('should return ApiErrorResult when file does not exist', () async {
      // Arrange
      when(mockProfileApiService.uploadProfilePhoto(any))
          .thenThrow(FileSystemException('File not found'));

      // Act
      final result = await remoteDataSource.uploadProfilePhoto(mockFile);

      // Assert
      expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
      verify(mockProfileApiService.uploadProfilePhoto(any)).called(1);
    });
  });

  group('ProfileRemoteDataSourceImpl - Edge Cases', () {
    test('getLoggedDriverData should handle null driver data gracefully', () async {
      // Arrange
      final mockDto = DriverProfileResponseDto(
        message: 'No driver data',
        driver: null,
      );

      when(mockProfileApiService.getLoggedDriverData())
          .thenAnswer((_) async => mockDto);

      // Act
      final result = await remoteDataSource.getLoggedDriverData();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverProfileResponseEntity>>());
      final successResult = result as ApiSuccessResult<DriverProfileResponseEntity>;
      expect(successResult.data.driver, isNull);
    });

    test('editProfile should handle empty response data', () async {
      // Arrange
      final mockDto = EditProfileResponseDto(
        message: '',
        driver: null,
      );

      final requestEntity = EditProfileRequestEntity(
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        phone: '+1234567890',
      );

      when(mockProfileApiService.editProfile(any))
          .thenAnswer((_) async => mockDto);

      // Act
      final result = await remoteDataSource.editProfile(requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
      final successResult = result as ApiSuccessResult<EditProfileResponseEntity>;
      expect(successResult.data.message, isEmpty);
    });
  });
}