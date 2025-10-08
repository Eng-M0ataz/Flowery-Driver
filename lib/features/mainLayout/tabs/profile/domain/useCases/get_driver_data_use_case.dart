import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDriverDataUseCase {
  GetDriverDataUseCase(this._profileRepo);
  final ProfileRepo _profileRepo;

  Future<ApiResult<GetDriverDataResponseEntity>> getDriverData() {
    return _profileRepo.getDriverData();
  }
}
