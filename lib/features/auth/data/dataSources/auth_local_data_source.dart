import 'package:flowery_tracking/core/errors/api_results.dart';

abstract interface class AuthLocalDataSource {
  Future<ApiResult<void>> writeToken({required String token});
  Future<ApiResult<void>> setRememberMe({required bool rememberMe});
  Future<bool> getRememberMe();
}