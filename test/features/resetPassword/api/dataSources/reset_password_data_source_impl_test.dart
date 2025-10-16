import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/resetPassword/api/client/reset_password_api_service.dart';
import 'package:flowery_tracking/features/resetPassword/api/dataSources/reset_password_data_source_impl.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_data_source_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordApiService])
void main() {
  late MockResetPasswordApiService mockResetPasswordApiService;
  late ResetPasswordRemoteDataSource dataSource;

  setUp(() {
    mockResetPasswordApiService = MockResetPasswordApiService();
    dataSource = ResetPasswordDataSourceImpl(mockResetPasswordApiService);
  });

  group('resetPassword', () {
    final tResetPasswordRequestModel = ResetPasswordRequestModel(
      password: 'oldPassword123',
      newPassword: 'newPassword123',
    );
    final tException = Exception('Something went wrong');

    test(
      'should return ApiSuccess<void> when the call to api service is successful',
      () async {
        // Arrange
        // The actual implementation of ResetPasswordDataSourceImpl uses an `executeApi` helper.
        // We only need to mock the underlying service call.
        when(
          mockResetPasswordApiService.resetPassword(any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await dataSource.resetPassword(
          tResetPasswordRequestModel,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<void>>());
        verify(
          mockResetPasswordApiService.resetPassword(tResetPasswordRequestModel),
        );
        verifyNoMoreInteractions(mockResetPasswordApiService);
      },
    );

    test(
      'should return ApiFailure when the call to api service throws an exception',
      () async {
        // Arrange
        when(
          mockResetPasswordApiService.resetPassword(any),
        ).thenThrow(tException);

        // Act
        final result = await dataSource.resetPassword(
          tResetPasswordRequestModel,
        );

        // Assert
        // The `executeApi` helper catches the exception and wraps it in an ApiFailure.
        expect(result, isA<ApiErrorResult>());
        verify(
          mockResetPasswordApiService.resetPassword(tResetPasswordRequestModel),
        );
        verifyNoMoreInteractions(mockResetPasswordApiService);
      },
    );
  });
}
