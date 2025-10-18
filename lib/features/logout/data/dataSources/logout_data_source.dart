import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/logout/domain/entities/logout_response_entity.dart';

abstract interface class LogoutDataSource{
  Future<ApiResult<LogoutResponseEntity>> logout();
}