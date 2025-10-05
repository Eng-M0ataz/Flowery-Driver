import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/execute_api.dart';
import 'package:flowery_tracking/features/resetPassword/api/client/reset_password_api_service.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordRemoteDataSource {
  ResetPasswordDataSourceImpl(this._resetPasswordApiService);
  final ResetPasswordApiService _resetPasswordApiService;

  @override
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return executeApi<void, void>(
      request: () =>
          _resetPasswordApiService.resetPassword(resetPasswordRequestModel),
      mapper: null,
    );
  }
}
