import 'package:flowery_tracking/core/utils/constants/api_constants.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/api/models/response/logout_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
part 'logout_api_service.g.dart';

@RestApi()
@injectable
abstract class LogoutApiService {
  @factoryMethod
  factory LogoutApiService(Dio dio) = _LogoutApiService;

  @GET(ApiConstants.logout)
  Future<LogoutResponseDto> logout();
}