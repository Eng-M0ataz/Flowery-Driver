import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:flowery_tracking/features/resetPassword/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([ResetPasswordRepo])
void main() {
  late MockResetPasswordRepo mockResetPasswordRepo;
  late ResetPasswordUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  setUp(() {
    mockResetPasswordRepo = MockResetPasswordRepo();
    useCase = ResetPasswordUseCase(mockResetPasswordRepo);
  });

  final tResetPasswordRequestModel = ResetPasswordRequestModel(
    password: 'oldPassword123',
    newPassword: 'newPassword123',
  );

  final tSuccessResult = ApiSuccessResult<void>(data: null);
  final tFailure = ServerFailure(errorMessage: 'Server error', code: '500');
  final tErrorResult = ApiErrorResult<void>(failure: tFailure);

  test(
    'should get success result from the repository when resetPassword is successful',
    () async {
      // Arrange
      when(
        mockResetPasswordRepo.resetPassword(any),
      ).thenAnswer((_) async => tSuccessResult);

      // Act
      final result = await useCase.invoke(tResetPasswordRequestModel);

      // Assert
      expect(result, tSuccessResult);
      verify(mockResetPasswordRepo.resetPassword(tResetPasswordRequestModel));
      verifyNoMoreInteractions(mockResetPasswordRepo);
    },
  );

  test(
    'should get error result from the repository when resetPassword fails',
    () async {
      // Arrange
      when(
        mockResetPasswordRepo.resetPassword(any),
      ).thenAnswer((_) async => tErrorResult);

      // Act
      final result = await useCase.invoke(tResetPasswordRequestModel);

      // Assert
      expect(result, tErrorResult);
      verify(mockResetPasswordRepo.resetPassword(tResetPasswordRequestModel));
      verifyNoMoreInteractions(mockResetPasswordRepo);
    },
  );
}
