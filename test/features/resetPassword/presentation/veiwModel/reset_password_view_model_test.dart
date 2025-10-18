import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_event.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_stats.dart';
import 'package:flowery_tracking/features/resetPassword/presentation/veiwModel/reset_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_view_model_test.mocks.dart';

@GenerateMocks([ResetPasswordUseCase])
void main() {
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late ResetPasswordViewModel viewModel;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  setUp(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    viewModel = ResetPasswordViewModel(mockResetPasswordUseCase);
  });

  final tResetPasswordRequestModel = ResetPasswordRequestModel(
    password: 'oldPassword123',
    newPassword: 'newPassword123',
  );

  test('initial state is correct', () {
    expect(viewModel.state, const ResetPasswordState());
  });

  group('doIntent - ResetPasswordEvent', () {
    final tSuccessResult = ApiSuccessResult<void>(data: null);
    final tFailure = ServerFailure(errorMessage: 'Server error', code: '500');
    final tErrorResult = ApiErrorResult<void>(failure: tFailure);

    blocTest<ResetPasswordViewModel, ResetPasswordState>(
      'emits [loading, success] when ResetPasswordUseCase is successful',
      build: () {
        when(
          mockResetPasswordUseCase.invoke(any),
        ).thenAnswer((_) async => tSuccessResult);
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(
        event: ResetPasswordEvent(),
        resetPasswordRequestModel: tResetPasswordRequestModel,
      ),
      expect: () => <ResetPasswordState>[
        const ResetPasswordState(isLoading: true),
        const ResetPasswordState(isLoading: false, resetPasswordSuccess: true),
      ],
      verify: (_) {
        verify(mockResetPasswordUseCase.invoke(tResetPasswordRequestModel));
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
    );

    blocTest<ResetPasswordViewModel, ResetPasswordState>(
      'emits [loading, failure] when ResetPasswordUseCase fails',
      build: () {
        when(
          mockResetPasswordUseCase.invoke(any),
        ).thenAnswer((_) async => tErrorResult);
        return viewModel;
      },
      act: (cubit) => cubit.doIntent(
        event: ResetPasswordEvent(),
        resetPasswordRequestModel: tResetPasswordRequestModel,
      ),
      expect: () => <ResetPasswordState>[
        const ResetPasswordState(isLoading: true),
        ResetPasswordState(isLoading: false, failure: tFailure),
      ],
      verify: (_) {
        verify(mockResetPasswordUseCase.invoke(tResetPasswordRequestModel));
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
    );
  });
}
