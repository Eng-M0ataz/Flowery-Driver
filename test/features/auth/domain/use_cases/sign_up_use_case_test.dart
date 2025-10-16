import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepo mockAuthRepo;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    signUpUseCase = SignUpUseCase(mockAuthRepo);
  });

  group('SignUpUseCase', () {
    final signUpRequest = SignUpRequestModel(
      firstName: 'test',
      lastName: 'user',
      email: 'test@test.com',
      password: 'password',
      phoneNumber: '1234567890',
      country: 'Egypt',
      vehicleType: 'car',
      vehicleNumber: '123',
      nationalId: '12345678901234',
      nationalIdImage: 'path/to/image',
      vehicleLicenseImage: 'path/to/image',
      confirmPassword: 'password',
      gender: 'male',
    );

    test('should call signUp on the repository', () async {
      // arrange
      when(mockAuthRepo.signUp(any)).thenAnswer((_) async => ApiSuccessResult(data: null));
      // act
      await signUpUseCase.invoke(signUpRequest);
      // assert
      verify(mockAuthRepo.signUp(signUpRequest));
      verifyNoMoreInteractions(mockAuthRepo);
    });
  });
}
