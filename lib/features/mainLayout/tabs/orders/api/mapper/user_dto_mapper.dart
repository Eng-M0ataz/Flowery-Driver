import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/user_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/user_entity.dart';

extension UserDtoMapper on UserDto{
  UserEntity toEntity(){
    return UserEntity(
      id: id ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      gender: gender ?? '',
      phone: phone ?? '',
      photo: photo ?? '',
      passwordChangedAt: passwordChangedAt ?? '',
    );
  }
}