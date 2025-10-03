import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_local_vehicle_types_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_use_case_test.mocks.dart';

void main() {
  late GetLocalVehicleTypesUseCase getLocalVehicleTypesUseCase;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    getLocalVehicleTypesUseCase = GetLocalVehicleTypesUseCase(mockAuthRepo);
  });

  group('GetLocalVehicleTypesUseCase', () {
    final vehicleTypes = VehicleTypesResponsEntity(vehicles: [
      VehicleTypeEntity(id: '1', type: 'car'),
      VehicleTypeEntity(id: '2', type: 'motorcycle'),
    ]);

    test('should get vehicle types from local repository', () async {
      // arrange
      when(mockAuthRepo.getVehicleTypesFromLocal())
          .thenAnswer((_) async => vehicleTypes);
      // act
      final result = await getLocalVehicleTypesUseCase.invoke();
      // assert
      expect(result, vehicleTypes);
      verify(mockAuthRepo.getVehicleTypesFromLocal());
      verifyNoMoreInteractions(mockAuthRepo);
    });
  });
}
