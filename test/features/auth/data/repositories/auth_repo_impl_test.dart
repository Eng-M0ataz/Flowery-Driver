import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
    provideDummy<ApiResult<VehicleTypesResponsEntity>>(
        ApiSuccessResult(data: VehicleTypesResponsEntity(vehicles: [])));
  });

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDataSource, mockAuthLocalDataSource);
  });

  group('AuthRepoImpl', () {
    group('signUp', () {
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

      test('should call signUp on the remote data source', () async {
        // arrange
        when(mockAuthRemoteDataSource.signUp(any))
            .thenAnswer((_) async => ApiSuccessResult(data: null));
        // act
        await authRepoImpl.signUp(signUpRequest);
        // assert
        verify(mockAuthRemoteDataSource.signUp(signUpRequest));
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });

    group('getVehicleTypes', () {
      final vehicleTypes = VehicleTypesResponsEntity(vehicles: [
        VehicleTypeEntity(id: '1', type: 'car'),
      ]);

      test('should call getVehicleTypes on the remote data source', () async {
        // arrange
        when(mockAuthRemoteDataSource.getVehicleTypes())
            .thenAnswer((_) async => ApiSuccessResult(data: vehicleTypes));
        // act
        final result = await authRepoImpl.getVehicleTypes();
        // assert
        expect(result, isA<ApiSuccessResult>());
        expect((result as ApiSuccessResult).data, vehicleTypes);
        verify(mockAuthRemoteDataSource.getVehicleTypes());
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    });

    group('getVehicleTypesFromLocal', () {
      final vehicleTypes = VehicleTypesResponsEntity(vehicles: [
        VehicleTypeEntity(id: '1', type: 'car'),
      ]);

      test('should call loadVehicleList on the local data source', () async {
        // arrange
        when(mockAuthLocalDataSource.loadVehicleList())
            .thenAnswer((_) async => vehicleTypes);
        // act
        final result = await authRepoImpl.getVehicleTypesFromLocal();
        // assert
        expect(result, vehicleTypes);
        verify(mockAuthLocalDataSource.loadVehicleList());
        verifyNoMoreInteractions(mockAuthLocalDataSource);
      });
    });
  });
}