import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/user_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/user_entity.dart';

extension UserDtoMapper on UserDto{
  UserEntity toEntity(){
    return UserEntity(
      Id: Id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      passwordChangedAt: passwordChangedAt,
    );
  }
}