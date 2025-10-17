import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:flowery_tracking/features/resetPassword/data/repositories/reset_password_repo_impl.dart';
import 'package:flowery_tracking/features/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_repo_impl_test.mocks.dart';

@GenerateMocks([ResetPasswordRemoteDataSource])
void main() {
  late MockResetPasswordRemoteDataSource mockResetPasswordRemoteDataSource;
  late ResetPasswordRepo repository;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  setUp(() {
    mockResetPasswordRemoteDataSource = MockResetPasswordRemoteDataSource();
    repository = ResetPasswordRepoImpl(mockResetPasswordRemoteDataSource);
  });

  group('resetPassword', () {
    final tResetPasswordRequestModel = ResetPasswordRequestModel(
      password: 'oldPassword123',
      newPassword: 'newPassword123',
    );
    final tSuccessResult = ApiSuccessResult<void>(data: null);
    final tFailure = ServerFailure(errorMessage: 'Server error', code: '500');
    final tErrorResult = ApiErrorResult<void>(failure: tFailure);

    test(
      'should return ApiSuccessResult from data source when the call is successful',
      () async {
        // Arrange
        when(
          mockResetPasswordRemoteDataSource.resetPassword(any),
        ).thenAnswer((_) async => tSuccessResult);

        // Act
        final result = await repository.resetPassword(
          tResetPasswordRequestModel,
        );

        // Assert
        expect(result, tSuccessResult);
        verify(
          mockResetPasswordRemoteDataSource.resetPassword(
            tResetPasswordRequestModel,
          ),
        );
        verifyNoMoreInteractions(mockResetPasswordRemoteDataSource);
      },
    );

    test(
      'should return ApiErrorResult from data source when the call is unsuccessful',
      () async {
        // Arrange
        when(
          mockResetPasswordRemoteDataSource.resetPassword(any),
        ).thenAnswer((_) async => tErrorResult);

        // Act
        final result = await repository.resetPassword(
          tResetPasswordRequestModel,
        );

        // Assert
        expect(result, tErrorResult);
        verify(
          mockResetPasswordRemoteDataSource.resetPassword(
            tResetPasswordRequestModel,
          ),
        );
        verifyNoMoreInteractions(mockResetPasswordRemoteDataSource);
      },
    );
  });
}
