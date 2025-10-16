import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flowery_tracking/features/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:flowery_tracking/features/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  ResetPasswordRepoImpl(this._resetPasswordDataSource);
  final ResetPasswordRemoteDataSource _resetPasswordDataSource;

  @override
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordDataSource.resetPassword(resetPasswordRequestModel);
  }
}
