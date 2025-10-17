import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';

Future<String> getInitialRoute() async {
  try {
    final storage = getIt<Storage>(instanceName: AppConstants.secureStorage);
    final rememberMeValue = await storage.read(key: AppConstants.rememberMe);

    if (rememberMeValue.toLowerCase() == 'true') {
      return AppRoutes.mainLayoutRoute;
    }
    return AppRoutes.signInRoute;
  } catch (e) {
    // If there's any error reading storage, default to sign in
    return AppRoutes.signInRoute;
  }
}
