import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_use_case_test.mocks.dart';

void main() {
  late GetVehicleTypesUseCase getVehicleTypesUseCase;
  late MockAuthRepo mockAuthRepo;

  setUpAll(() {
    provideDummy<ApiResult<VehicleTypesResponsEntity>>(
        ApiSuccessResult(data: VehicleTypesResponsEntity(vehicles: [])));
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    getVehicleTypesUseCase = GetVehicleTypesUseCase(mockAuthRepo);
  });

  group('GetVehicleTypesUseCase', () {
    final vehicleTypes = VehicleTypesResponsEntity(vehicles: [
      VehicleTypeEntity(id: '1', type: 'car'),
      VehicleTypeEntity(id: '2', type: 'motorcycle'),
    ]);

    test('should get vehicle types from the repository', () async {
      // arrange
      when(mockAuthRepo.getVehicleTypes())
          .thenAnswer((_) async => ApiSuccessResult(data: vehicleTypes));
      // act
      final result = await getVehicleTypesUseCase.invoke();
      // assert
      expect(result, isA<ApiSuccessResult>());
      expect((result as ApiSuccessResult).data, vehicleTypes);
      verify(mockAuthRepo.getVehicleTypes());
      verifyNoMoreInteractions(mockAuthRepo);
    });
  });
}