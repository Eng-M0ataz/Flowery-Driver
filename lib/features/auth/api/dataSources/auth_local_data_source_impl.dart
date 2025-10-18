import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  AuthLocalDataSourceImpl(@Named(AppConstants.secureStorage) this._storage);
  final Storage _storage;

  @override
  Future<ApiResult<void>> writeToken({required String token}) async {
    try {
      await _storage.write(key: AppConstants.token, value: token);

      return ApiSuccessResult<void>(data: null);
    } catch (e) {
      return ApiErrorResult<void>(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<void>> setRememberMe({required bool rememberMe}) async {
    try {
      await _storage.write(
        key: AppConstants.rememberMe,
        value: rememberMe.toString(),
      );
      return ApiSuccessResult<void>(data: null);
    } catch (e) {
      return ApiErrorResult<void>(failure: Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<bool> getRememberMe() async {
    final String value = await _storage.read(key: AppConstants.rememberMe);
    return value.toLowerCase() == 'true';
  }
}
