import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_local_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'auth_local_data_source_impl_test.mocks.dart';

@GenerateMocks([Storage])
void main() {
  late AuthLocalDataSourceImpl authLocalDataSourceImpl;
  late MockStorage mockStorage;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockStorage = MockStorage();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(mockStorage);
  });

  group('AuthLocalDataSourceImpl', () {
    test(
      'should return VehicleTypesResponsEntity when loadVehicleList is called',
      () async {
        // act
        final result = await authLocalDataSourceImpl.loadVehicleList();

        // assert
        expect(result, isA<VehicleTypesResponsEntity>());
        expect(result.vehicles, isNotEmpty);
      },
    );
  });
}
