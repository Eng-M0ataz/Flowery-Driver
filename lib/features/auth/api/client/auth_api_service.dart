import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/response/vehicle/vehicle_types_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service.g.dart';

@singleton
@RestApi()
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;
  @POST(ApiConstants.signUp)
  Future<void> signUp(@Body() FormData formData);
  @GET(ApiConstants.vehicles)
  Future<VehicleTypesResponseDto> getVehicleTypes();
}
