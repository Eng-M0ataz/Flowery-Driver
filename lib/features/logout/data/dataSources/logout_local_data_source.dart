import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/local_results.dart';

abstract interface class LogoutLocalDataSource{
  Future <LocalResult<void>> localLogout();
}