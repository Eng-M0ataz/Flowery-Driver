import 'package:flowery_tracking/features/mainLayout/tabs/profile/api/model/requestes/edit_profile_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';

extension EditProfileRequestMapper on EditProfileRequestEntity{
  EditProfileRequestModel toModel(){
    return EditProfileRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      gender: gender,
    );
  }
}