import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  @override
  Future<ApiResult<void>> signUp(SignUpRequestModel signUpRequest) {
    return _authRemoteDataSource.signUp(signUpRequest);
  }

  @override
  Future<ApiResult<VehicleTypesResponsEntity>> getVehicleTypes() async {
    return await _authRemoteDataSource.getVehicleTypes();
  }

  @override
  Future<VehicleTypesResponsEntity> getVehicleTypesFromLocal() async {
    return await _authLocalDataSource.loadVehicleList();
  }
}
