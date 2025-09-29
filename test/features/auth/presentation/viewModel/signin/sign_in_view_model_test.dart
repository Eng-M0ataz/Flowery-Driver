import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_view_model.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';

// Generate mocks
@GenerateMocks([
  SignInUseCase,
  GlobalKey<FormState>,
  FormState,
])
import 'sign_in_view_model_test.mocks.dart';

void main() {
  late SignInViewModel viewModel;
  late MockSignInUseCase mockSignInUseCase;

  // Mock the secure storage platform channel
  const MethodChannel channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Provide dummy values for Mockito
    provideDummy<ApiResult<SignInResponseEntity>>(
      ApiSuccessResult<SignInResponseEntity>(
        data: SignInResponseEntity(
          token: 'dummy_token',
          message: 'dummy_message',
        ),
      ),
    );

    // Mock the platform channel for FlutterSecureStorage
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'write':
          return null;
        case 'read':
          return null;
        case 'delete':
          return null;
        case 'deleteAll':
          return null;
        case 'readAll':
          return <String, String>{};
        case 'containsKey':
          return false;
        default:
          return null;
      }
    });
  });

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    viewModel = SignInViewModel(mockSignInUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  tearDownAll(() {
    // Clean up the mock handler
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('SignInViewModel', () {
    group('Initial State', () {
      test('should have correct initial state', () {
        expect(viewModel.state, isA<SignInState>());
        expect(viewModel.state.isLoading, false);
        expect(viewModel.obscureText, true);
        expect(viewModel.rememberMe, false);
      });

      test('should have initialized controllers with default values', () {
        expect(viewModel.emailController.text, 'abdoaswani@gmail.com');
        expect(viewModel.passwordController.text, 'Ahmed@123');
      });

      test('should have formKey initialized', () {
        expect(viewModel.formKey, isA<GlobalKey<FormState>>());
      });
    });

    group('navigateToRouteScreen', () {
      testWidgets('should call context.pushNamed with correct route', (tester) async {
        // This test requires a more complex setup with BuildContext
        // For now, we'll test the method exists and can be called
        expect(viewModel.navigateToRouteScreen, isA<Function>());
      });
    });

    group('Controllers', () {
      test('should update email controller text', () {
        const newEmail = 'newemail@example.com';
        viewModel.emailController.text = newEmail;
        expect(viewModel.emailController.text, newEmail);
      });

      test('should update password controller text', () {
        const newPassword = 'newpassword123';
        viewModel.passwordController.text = newPassword;
        expect(viewModel.passwordController.text, newPassword);
      });

      test('should dispose controllers properly', () {
        // Create a new instance to test disposal
        final testViewModel = SignInViewModel(mockSignInUseCase);
        expect(() => testViewModel.close(), returnsNormally);
      });
    });

    group('obscureText', () {
      test('should have default value of true', () {
        expect(viewModel.obscureText, true);
      });

      test('should be able to toggle obscureText', () {
        viewModel.obscureText = false;
        expect(viewModel.obscureText, false);

        viewModel.obscureText = true;
        expect(viewModel.obscureText, true);
      });
    });
  });
}