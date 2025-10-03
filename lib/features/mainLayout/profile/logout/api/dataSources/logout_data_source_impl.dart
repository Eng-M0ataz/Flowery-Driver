import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/api/client/logout_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/api/mapper/logout_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/api/models/response/logout_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/data/dataSources/logout_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/domain/entities/logout_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutDataSource)
class LogoutDataSourceImpl implements LogoutDataSource {
  final LogoutApiService _logoutApiService;

  LogoutDataSourceImpl(this._logoutApiService);

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() {
    return executeApi<LogoutResponseDto, LogoutResponseEntity>(
      request: () => _logoutApiService.logout(),
      mapper: (dto) => dto.toEntity(),
    );
  }
}