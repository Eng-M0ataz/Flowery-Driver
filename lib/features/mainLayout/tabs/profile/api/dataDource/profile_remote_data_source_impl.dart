import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/mapper/profile_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/driver_profile_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_profile_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  ProfileRemoteDataSourceImpl({required ProfileApiService profileApiService})
    : _profileApiService = profileApiService;

  final ProfileApiService _profileApiService;

  @override
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData() async{
    return executeApi<DriverProfileResponseDto, DriverProfileResponseEntity>(
      request: () => _profileApiService.getLoggedDriverData(),
      mapper: (res) => res.toEntity(),
    );
  }
}
