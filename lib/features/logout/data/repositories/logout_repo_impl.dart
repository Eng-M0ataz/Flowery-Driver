import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/local_results.dart';
import 'package:flowery_tracking/features/logout/data/dataSources/logout_data_source.dart';
import 'package:flowery_tracking/features/logout/data/dataSources/logout_local_data_source.dart';
import 'package:flowery_tracking/features/logout/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking/features/logout/domain/repositories/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImpl implements LogoutRepo {
  final LogoutDataSource _logoutDataSource;
  final LogoutLocalDataSource _logoutLocalDataSource;

  LogoutRepoImpl(this._logoutDataSource,this._logoutLocalDataSource);

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() {
    return _logoutDataSource.logout();
  }
  @override
  Future<LocalResult> localLogout() {
    return _logoutLocalDataSource.localLogout();
  }
}