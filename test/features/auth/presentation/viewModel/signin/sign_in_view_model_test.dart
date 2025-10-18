import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_view_model.dart';

// Generate mocks
@GenerateMocks([SignInUseCase, BuildContext])
import 'sign_in_view_model_test.mocks.dart';

void main() {
  late SignInViewModel viewModel;
  late MockSignInUseCase mockSignInUseCase;
  late MockBuildContext mockContext;

  // Create dummy values
  final dummyResponseEntity = SignInResponseEntity(
    token: 'dummy_token',
    message: 'dummy_message',
  );

  final dummySuccessResult = ApiSuccessResult<SignInResponseEntity>(
    data: dummyResponseEntity,
  );

  setUpAll(() {
    // Provide dummy values for Mockito
    provideDummy<ApiResult<SignInResponseEntity>>(dummySuccessResult);
  });

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockContext = MockBuildContext();
    viewModel = SignInViewModel(mockSignInUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group('SignInViewModel', () {
    test('initial state should be SignInState with default values', () {
      // Assert
      expect(viewModel.state, isA<SignInState>());
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.obscureText, true);
      expect(viewModel.state.isRememberMe, false);
      expect(viewModel.state.failure, isNull);
      expect(viewModel.state.response, isNull);
    });

    group('doIntent - SignInEvent', () {
      const email = 'test@example.com';
      const password = 'password123';
      final signInEvent = SignInEvent(email: email, password: password);
      final responseEntity = SignInResponseEntity(token: 'token123', message: 'Success');

      test('should emit loading state and then success state when sign in succeeds', () async {
        // Arrange
        final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);

        // Set up the mock
        when(mockSignInUseCase.invoke(
          requestEntity: anyNamed('requestEntity'),
          rememberMeChecked: anyNamed('rememberMeChecked'),
        )).thenAnswer((_) async => successResult);

        // Act & Assert
        final states = <SignInState>[];
        final subscription = viewModel.stream.listen(states.add);

        viewModel.doIntent(event: signInEvent);

        // Wait for the async operation to complete
        await Future.delayed(Duration(milliseconds: 100));

        // Verify states
        expect(states.length, greaterThanOrEqualTo(2));
        expect(states[0].isLoading, true);
        expect(states.last.isLoading, false);
        expect(states.last.response, responseEntity);
        expect(states.last.failure, isNull);

        // Verify the method was called with correct parameters using captured arguments
        final captured = verify(mockSignInUseCase.invoke(
          requestEntity: captureAnyNamed('requestEntity'),
          rememberMeChecked: captureAnyNamed('rememberMeChecked'),
        )).captured;

        expect(captured.length, 2);
        final capturedRequest = captured[0] as SignInRequestEntity;
        final capturedRememberMe = captured[1] as bool;

        expect(capturedRequest.email, email);
        expect(capturedRequest.password, password);
        expect(capturedRememberMe, false);

        subscription.cancel();
      });

      test('should emit loading state and then error state when sign in fails', () async {
        // Arrange
        const errorMessage = 'Invalid credentials';
        final failure = Failure(errorMessage: errorMessage);
        final errorResult = ApiErrorResult<SignInResponseEntity>(failure: failure);

        when(mockSignInUseCase.invoke(
          requestEntity: anyNamed('requestEntity'),
          rememberMeChecked: anyNamed('rememberMeChecked'),
        )).thenAnswer((_) async => errorResult);

        // Act & Assert
        final states = <SignInState>[];
        final subscription = viewModel.stream.listen(states.add);

        viewModel.doIntent(event: signInEvent);

        // Wait for the async operation to complete
        await Future.delayed(Duration(milliseconds: 100));

        // Verify states
        expect(states.length, greaterThanOrEqualTo(2));
        expect(states[0].isLoading, true);
        expect(states.last.isLoading, false);
        expect(states.last.response, isNull);
        expect(states.last.failure?.errorMessage, errorMessage);

        // Verify the method was called
        verify(mockSignInUseCase.invoke(
          requestEntity: anyNamed('requestEntity'),
          rememberMeChecked: anyNamed('rememberMeChecked'),
        )).called(1);

        subscription.cancel();
      });

      test('should pass rememberMe value to use case when set to true', () async {
        // Arrange
        final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);

        when(mockSignInUseCase.invoke(
          requestEntity: anyNamed('requestEntity'),
          rememberMeChecked: anyNamed('rememberMeChecked'),
        )).thenAnswer((_) async => successResult);

        // Set rememberMe to true
        viewModel.rememberMe = true;

        // Act
        viewModel.doIntent(event: signInEvent);

        // Wait for the call to complete
        await Future.delayed(Duration(milliseconds: 100));

        // Verify with captured arguments
        final captured = verify(mockSignInUseCase.invoke(
          requestEntity: captureAnyNamed('requestEntity'),
          rememberMeChecked: captureAnyNamed('rememberMeChecked'),
        )).captured;

        expect(captured.length, 2);
        final capturedRememberMe = captured[1] as bool;
        expect(capturedRememberMe, true);
      });
    });

    group('doIntent - TogglePasswordEvent', () {
      test('should toggle obscureText from true to false', () async {
        // Arrange
        expect(viewModel.state.obscureText, true);

        // Act & Assert
        final states = <SignInState>[];
        final subscription = viewModel.stream.listen(states.add);

        viewModel.doIntent(event: TogglePasswordEvent());

        // Wait for state to be emitted
        await Future.delayed(Duration.zero);

        expect(states.length, greaterThanOrEqualTo(1));
        expect(states.last.obscureText, false);
        subscription.cancel();
      });

      test('should toggle obscureText from false to true', () async {
        // Arrange - set initial state to false
        viewModel.emit( SignInState(obscureText: false));
        expect(viewModel.state.obscureText, false);

        // Act & Assert
        final states = <SignInState>[];
        final subscription = viewModel.stream.listen(states.add);

        viewModel.doIntent(event: TogglePasswordEvent());

        // Wait for state to be emitted
        await Future.delayed(Duration.zero);

        expect(states.length, greaterThanOrEqualTo(1));
        expect(states.last.obscureText, true);
        subscription.cancel();
      });
    });

    group('doIntent - ToggleRememberMeEvent', () {
      test('should eventually update state', () async {
        // This tests state updates with a more robust approach
        final states = <SignInState>[];
        final subscription = viewModel.stream.listen(states.add);

        // Store initial state for comparison
        final initialState = viewModel.state;

        viewModel.doIntent(event: ToggleRememberMeEvent(isRememberMe: true));

        // Wait with multiple checks
        bool stateUpdated = false;
        for (int i = 0; i < 10; i++) {
          await Future.delayed(Duration(milliseconds: 10));
          if (viewModel.state.isRememberMe != initialState.isRememberMe) {
            stateUpdated = true;
            break;
          }
        }

        print('State updated: $stateUpdated');
        print('Current state: ${viewModel.state}');
        print('States emitted: ${states.length}');

        // Check if state was updated (either through emission or direct change)
        expect(viewModel.state.isRememberMe, true, reason: 'State should eventually show isRememberMe: true');

        subscription.cancel();
      });
    });

  });
}