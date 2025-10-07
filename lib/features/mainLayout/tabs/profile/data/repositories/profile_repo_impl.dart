import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo{
  ProfileRepoImpl({required ProfileRemoteDataSource profileRemoteDataSource}) : _profileRemoteDataSource = profileRemoteDataSource;
  final ProfileRemoteDataSource _profileRemoteDataSource;

  @override
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData() {
    return _profileRemoteDataSource.getLoggedDriverData();
  }
}