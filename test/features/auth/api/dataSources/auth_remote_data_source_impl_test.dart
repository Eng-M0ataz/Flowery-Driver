import 'package:dio/dio.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks
@GenerateMocks([AuthApiService])
import 'auth_remote_data_source_impl_test.mocks.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockAuthApiService mockApiService;

  setUp(() {
    mockApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImpl(mockApiService);
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
        expect(success.data.message, responseEntity.message);
        expect(success.data.token, responseEntity.token);

        verify(mockApiService.signIn(requestDto: anyNamed('requestDto'))).called(1);
      });

      test('should return ApiErrorResult with ServerFailure when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/signin'),
          type: DioExceptionType.connectionTimeout,
        );

        when(mockApiService.signIn(requestDto: anyNamed('requestDto')))
            .thenThrow(dioException);

        // Act
        final result = await dataSource.signIn(requestEntity: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SignInResponseEntity>>());
        final errorResult = result as ApiErrorResult<SignInResponseEntity>;
        expect(errorResult.failure, isA<ServerFailure>());

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
        final errorResult = result as ApiErrorResult<SignInResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        expect(errorResult.failure.errorMessage, contains('Exception: $errorMessage'));

        verify(mockApiService.signIn(requestDto: anyNamed('requestDto'))).called(1);
      });

    });
  });
}