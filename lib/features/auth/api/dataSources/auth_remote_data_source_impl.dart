import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signUp/request/sign_up_req_mapper.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signUp/response/vehicle_type_mapper.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiServices);
  final AuthApiService _apiServices;

  @override
  Future<ApiResult<void>> signUp(SignUpRequestModel signUpRequest) {
    return executeApi<void, void>(
      request: () async =>
          _apiServices.signUp(await signUpRequest.toFormData()),
      mapper: null,
    );
  }

  @override
  Future<ApiResult<VehicleTypesResponsEntity>> getVehicleTypes() async {
    return await executeApi<VehicleTypesResponseDto, VehicleTypesResponsEntity>(
      request: () => _apiServices.getVehicleTypes(),
      mapper: (response) => response.toEntity(),
    );
  }
}
