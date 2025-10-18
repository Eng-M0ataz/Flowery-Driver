import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';

extension SignInDtoMapper on SignInResponseDto{
  SignInResponseEntity toEntity(){
    return SignInResponseEntity(message: message ?? '', token: token ?? '');
  }
}