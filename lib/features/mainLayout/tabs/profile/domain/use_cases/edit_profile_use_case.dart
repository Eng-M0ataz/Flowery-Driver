import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';


@injectable
class EditProfileUseCase{
  EditProfileUseCase({required ProfileRepo profileRepo}) : _profileRepo = profileRepo;
  final ProfileRepo _profileRepo;

  Future<ApiResult<EditProfileResponseEntity>> call(EditProfileRequestEntity editProfileRequestEntity){
    return _profileRepo.editProfile(editProfileRequestEntity);
  }

}