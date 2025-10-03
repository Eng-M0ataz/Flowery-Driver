import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<void>> signUp(SignUpRequestModel signUpRequest);
  Future<ApiResult<VehicleTypesResponsEntity>> getVehicleTypes();
}
