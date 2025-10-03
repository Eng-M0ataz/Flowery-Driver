import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking/core/aiLayer/domain/useCases/validate_data_use_case.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_local_vehicle_types_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_cubit_test.mocks.dart';

@GenerateMocks([
  SignUpUseCase,
  GetVehicleTypesUseCase,
  GetLocalVehicleTypesUseCase,
  ValidateDataUseCase
])
void main() {
  late SignUpCubit signUpCubit;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockGetVehicleTypesUseCase mockGetVehicleTypesUseCase;
  late MockGetLocalVehicleTypesUseCase mockGetLocalVehicleTypesUseCase;
  late MockValidateDataUseCase mockValidateDataUseCase;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
    provideDummy<ApiResult<VehicleTypesResponsEntity>>(
        ApiSuccessResult(data: VehicleTypesResponsEntity(vehicles: [])));
  });

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockGetVehicleTypesUseCase = MockGetVehicleTypesUseCase();
    mockGetLocalVehicleTypesUseCase = MockGetLocalVehicleTypesUseCase();
    mockValidateDataUseCase = MockValidateDataUseCase();
    signUpCubit = SignUpCubit(
      mockSignUpUseCase,
      mockValidateDataUseCase,
      mockGetVehicleTypesUseCase,
      mockGetLocalVehicleTypesUseCase,
    );
  });

  group('SignUpCubit', () {
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

    final vehicleTypes = VehicleTypesResponsEntity(vehicles: [
      VehicleTypeEntity(id: '1', type: 'car'),
    ]);

    blocTest<SignUpCubit, SignUpCubitState>(
      'emits [isLoading: true, isLoading: false] when signUp is successful',
      build: () {
        when(mockSignUpUseCase.invoke(any))
            .thenAnswer((_) async => ApiSuccessResult(data: null));
        return signUpCubit;
      },
      act: (cubit) =>
          cubit.doIntent(event: SignUpEvent(), signUpRequest: signUpRequest),
      expect: () => [
        const SignUpCubitState(isLoading: true),
        const SignUpCubitState(isLoading: false),
      ],
    );

    blocTest<SignUpCubit, SignUpCubitState>(
      'emits [vehicleList] when getVehicleTypes is successful',
      build: () {
        when(mockGetVehicleTypesUseCase.invoke())
            .thenAnswer((_) async => ApiSuccessResult(data: vehicleTypes));
        return signUpCubit;
      },
      act: (cubit) => cubit.doIntent(event: GetVehicleTypes()),
      expect: () => [
        SignUpCubitState(vehicleList: vehicleTypes.vehicles),
      ],
    );

    blocTest<SignUpCubit, SignUpCubitState>(
      'emits [vehicleList] from local when getVehicleTypes fails',
      build: () {
        when(mockGetVehicleTypesUseCase.invoke())
            .thenAnswer((_) async => ApiErrorResult(failure: Failure(errorMessage: 'test error')));
        when(mockGetLocalVehicleTypesUseCase.invoke())
            .thenAnswer((_) async => vehicleTypes);
        return signUpCubit;
      },
      act: (cubit) => cubit.doIntent(event: GetVehicleTypes()),
      expect: () => [
        SignUpCubitState(vehicleList: vehicleTypes.vehicles),
      ],
    );
  });
}