
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/domain/entities/logout_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/profile/logout/domain/repositories/logout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepo _logoutRepo;

  LogoutUseCase(this._logoutRepo);

  Future<ApiResult<LogoutResponseEntity>> invoke() {
    return _logoutRepo.logout();
  }
}