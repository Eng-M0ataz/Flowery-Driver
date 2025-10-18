import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/core/errors/local_results.dart';
import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/logout/data/dataSources/logout_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutLocalDataSource)
class LogoutLocalDataSourceImpl implements LogoutLocalDataSource {
  final Storage _storage;

  LogoutLocalDataSourceImpl(@Named(AppConstants.secureStorage) this._storage);

  @override
  Future<LocalResult<void>> localLogout() async {
    try {
      await _storage.delete(key: AppConstants.token);
      await _storage.delete(key: AppConstants.rememberMe);
      return LocalSuccessResult<void>(data: null);
    } catch (e) {
      final failure = SecureStorageFailure.fromException(e);
      return LocalErrorResult<void>(
        failure:failure,
      );
    }
  }
}