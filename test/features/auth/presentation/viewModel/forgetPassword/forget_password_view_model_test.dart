import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/forget_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/reset_password_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/forgetPassword/response/verify_reset_code_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_event.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUseCase,
  VerifyResetCodeUseCase,
  ResetPasswordUseCase,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  final testForgetResponse = ForgetPasswordResponseEntity(
    message: 'Success',
    info: 'Code sent to email',
  );

  final testVerifyResponse = VerifyResetCodeResponseEntity(status: 'verified');

  final testResetResponse = ResetPasswordResponseEntity(
    message: 'Password reset successful',
    token: 'new_token_123',
  );

  final testFailure = ServerFailure(errorMessage: 'Server Error');

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();

    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiSuccessResult(data: testForgetResponse),
    );
    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiSuccessResult(data: testVerifyResponse),
    );
    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiSuccessResult(data: testResetResponse),
    );
  });

  group('ForgetPasswordViewModel Tests', () {
    test('Initial state should be an empty ForgetPasswordState', () {
      final viewModel = ForgetPasswordViewModel(
        mockForgetPasswordUseCase,
        mockVerifyResetCodeUseCase,
        mockResetPasswordUseCase,
      );

      expect(viewModel.state, const ForgetPasswordState());
    });

    group('SendForgetRequestEvent', () {
      testWidgets('Should emit forgetResponse when forget use case succeeds', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockForgetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult<ForgetPasswordResponseEntity>(
            data: testForgetResponse,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.forgetPasswordKey,
                child: TextFormField(
                  controller: viewModel.emailController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.emailController.text = 'test@test.com';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(SendForgetRequestEvent());

        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.forgetResponse, testForgetResponse);
        expect(states.last.step, ForgetPasswordStep.verify);
        expect(states.last.status, ForgetPasswordStatus.success);
        verify(mockForgetPasswordUseCase.invoke(any)).called(1);

        await viewModel.close();
      });

      testWidgets('Should emit failure when forget use case fails', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockForgetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiErrorResult<ForgetPasswordResponseEntity>(
            failure: testFailure,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.forgetPasswordKey,
                child: TextFormField(
                  controller: viewModel.emailController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.emailController.text = 'test@test.com';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(SendForgetRequestEvent());
        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.failure, testFailure);
        expect(states.last.status, ForgetPasswordStatus.error);
        verify(mockForgetPasswordUseCase.invoke(any)).called(1);

        await viewModel.close();
      });
    });

    group('VerifyCodeEvent', () {
      testWidgets('Should emit verifyResponse when verify use case succeeds', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockVerifyResetCodeUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult<VerifyResetCodeResponseEntity>(
            data: testVerifyResponse,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.verifyCodeKey,
                child: TextFormField(
                  controller: viewModel.codeController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.codeController.text = '1234';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(VerifyCodeEvent());
        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.verifyResponse, testVerifyResponse);
        expect(states.last.step, ForgetPasswordStep.reset);
        expect(states.last.status, ForgetPasswordStatus.success);
        verify(mockVerifyResetCodeUseCase.invoke(any)).called(1);

        await viewModel.close();
      });

      testWidgets('Should emit failure when verify use case fails', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockVerifyResetCodeUseCase.invoke(any)).thenAnswer(
          (_) async => ApiErrorResult<VerifyResetCodeResponseEntity>(
            failure: testFailure,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.verifyCodeKey,
                child: TextFormField(
                  controller: viewModel.codeController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.codeController.text = '1234';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(VerifyCodeEvent());
        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.failure, testFailure);
        expect(states.last.status, ForgetPasswordStatus.error);
        verify(mockVerifyResetCodeUseCase.invoke(any)).called(1);

        await viewModel.close();
      });
    });

    group('ResetPasswordEvent', () {
      testWidgets('Should emit resetResponse when reset use case succeeds', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockResetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult<ResetPasswordResponseEntity>(
            data: testResetResponse,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        viewModel.emit(
          viewModel.state.copyWith(
            email: 'test@test.com',
            step: ForgetPasswordStep.reset,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.resetPasswordKey,
                child: TextFormField(
                  controller: viewModel.newPasswordController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.newPasswordController.text = 'newPass123';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(ResetPasswordEvent());
        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.resetResponse, testResetResponse);
        expect(states.last.status, ForgetPasswordStatus.success);
        verify(mockResetPasswordUseCase.invoke(any)).called(1);

        await viewModel.close();
      });

      testWidgets('Should emit failure when reset use case fails', (
        WidgetTester tester,
      ) async {
        // Arrange
        when(mockResetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async =>
              ApiErrorResult<ResetPasswordResponseEntity>(failure: testFailure),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        viewModel.emit(
          viewModel.state.copyWith(
            email: 'test@test.com',
            step: ForgetPasswordStep.reset,
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                key: viewModel.resetPasswordKey,
                child: TextFormField(
                  controller: viewModel.newPasswordController,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Required' : null,
                ),
              ),
            ),
          ),
        );

        viewModel.newPasswordController.text = 'newPass123';

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(ResetPasswordEvent());
        await tester.pump();

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.failure, testFailure);
        expect(states.last.status, ForgetPasswordStatus.error);
        verify(mockResetPasswordUseCase.invoke(any)).called(1);

        await viewModel.close();
      });
    });

    group('ResendCodeEvent', () {
      test('Should resend code successfully', () async {
        // Arrange
        when(mockForgetPasswordUseCase.invoke(any)).thenAnswer(
          (_) async => ApiSuccessResult<ForgetPasswordResponseEntity>(
            data: testForgetResponse,
          ),
        );

        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        viewModel.emit(
          viewModel.state.copyWith(
            email: 'test@test.com',
            step: ForgetPasswordStep.verify,
          ),
        );

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(ResendCodeEvent());

        await Future.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.forgetResponse, testForgetResponse);
        expect(states.last.step, ForgetPasswordStep.resend);
        expect(states.last.status, ForgetPasswordStatus.success);
        expect(states.last.isResendAvailable, false);
        verify(mockForgetPasswordUseCase.invoke(any)).called(1);

        await viewModel.close();
      });
    });

    group('ResendTimerFinishedEvent', () {
      test('Should enable resend when timer finishes', () async {
        // Arrange
        final viewModel = ForgetPasswordViewModel(
          mockForgetPasswordUseCase,
          mockVerifyResetCodeUseCase,
          mockResetPasswordUseCase,
        );

        viewModel.emit(viewModel.state.copyWith(isResendAvailable: false));

        final states = <ForgetPasswordState>[];
        viewModel.stream.listen((state) => states.add(state));

        // Act
        await viewModel.doIntent(ResendTimerFinishedEvent());

        // Assert
        expect(states.isNotEmpty, true);
        expect(states.last.isResendAvailable, true);

        await viewModel.close();
      });
    });
  });
}
