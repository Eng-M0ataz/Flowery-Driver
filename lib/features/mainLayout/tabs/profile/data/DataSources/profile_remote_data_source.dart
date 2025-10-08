import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';

abstract class  ProfileRemoteDataSource {
  Future<ApiResult<GetDriverDataResponseEntity>> getDriverData();

  Future<ApiResult<GetAllVehiclesResponseEntity>> getAllVehicles();
}