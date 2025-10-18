import 'package:flowery_tracking/features/auth/api/model/signIn/request/sign_in_request_dto.dart';

class SignInRequestEntity {
  SignInRequestEntity({required this.email,required this.password});

  final String email;

  final String password;

  SignInRequestDto toDto(){
    return SignInRequestDto(
        email: email,
        password: password
    );
  }
}
