import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/request/sign_in_request_dto.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service.g.dart';

@singleton
@RestApi()
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiConstants.signIn)
  Future<SignInResponseDto>signIn({@Body() required SignInRequestDto requestDto});
}
