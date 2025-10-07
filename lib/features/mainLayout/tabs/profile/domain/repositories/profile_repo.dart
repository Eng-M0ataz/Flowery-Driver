import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_profile_response_entity.dart';

abstract class ProfileRepo{
  Future<ApiResult<DriverProfileResponseEntity>> getLoggedDriverData();
}