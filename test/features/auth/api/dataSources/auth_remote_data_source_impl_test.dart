import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_meta_data_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiService])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late MockAuthApiService mockAuthApiService;

  setUp(() {
    mockAuthApiService = MockAuthApiService();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(mockAuthApiService);
  });

  group('AuthRemoteDataSourceImpl', () {
    group('getVehicleTypes', () {
      final vehicleTypesDto = const VehicleTypesResponseDto(
        message: 'success',
        metadata: Metadata(
          currentPage: 1,
          totalPages: 1,
          limit: 10,
          totalItems: 1,
        ),
        vehicles: [],
      );
      test(
        'should return ApiSuccessResult with VehicleTypesResponsEntity when getVehicleTypes is successful',
        () async {
          // arrange
          when(
            mockAuthApiService.getVehicleTypes(),
          ).thenAnswer((_) async => vehicleTypesDto);
          // act
          final result = await authRemoteDataSourceImpl.getVehicleTypes();
          // assert
          expect(result, isA<ApiSuccessResult<VehicleTypesResponsEntity>>());
        },
      );
    });
  });
}
