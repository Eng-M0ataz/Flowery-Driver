
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/DataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl(this._dataSource);
  final ProfileRemoteDataSource _dataSource;

  @override
  Future<ApiResult<GetDriverDataResponseEntity>> getDriverData() {
    return _dataSource.getDriverData();
  }

  @override
  Future<ApiResult<GetAllVehiclesResponseEntity>> getAllVehicles() {
    return _dataSource.getAllVehicles();
  }

}