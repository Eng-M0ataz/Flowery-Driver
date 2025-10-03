
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/data/dataSources/logout_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/domain/repositories/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImpl implements LogoutRepo {
  final LogoutDataSource _logoutDataSource;

  LogoutRepoImpl(this._logoutDataSource);

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() {
    return _logoutDataSource.logout();
  }
}