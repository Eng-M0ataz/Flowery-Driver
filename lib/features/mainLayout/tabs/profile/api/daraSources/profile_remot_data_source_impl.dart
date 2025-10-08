
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mappers/response/driver_data_response_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mappers/response/get_all_vehicles_response_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_all_vehicles_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/models/response/get_driver_data_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/DataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl(this._apiService);
  final ProfileApiService _apiService;
  
  @override
  Future<ApiResult<GetDriverDataResponseEntity>> getDriverData() {
    return executeApi<GetDriverDataResponseDto, GetDriverDataResponseEntity>(
      request: () => _apiService.getDriverData(),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<GetAllVehiclesResponseEntity>> getAllVehicles() {
    return executeApi<GetAllVehiclesResponseDto, GetAllVehiclesResponseEntity>(
      request: () => _apiService.getAllVehicles(),
      mapper: (dto) => dto.toEntity(),
    );
  }

}