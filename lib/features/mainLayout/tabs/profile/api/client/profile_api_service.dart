
import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_all_vehicles_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_driver_data_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_service.g.dart';

@RestApi()
@singleton
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(ApiConstants.getDriverData)
  Future<GetDriverDataResponseDto> getDriverData();

  @GET(ApiConstants.getAllVehicles)
  Future<GetAllVehiclesResponseDto> getAllVehicles();
}