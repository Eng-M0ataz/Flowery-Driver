import 'package:flowery_tracking/core/config/routing/app_routes.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/execute_navigation.dart';
import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeStorage implements Storage {
  _FakeStorage(this.map);
  final Map<String, String> map;

  @override
  Future<void> delete({required String key}) async {
    map.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    map.clear();
  }

  @override
  Future<String> read({required String key}) async => map[key] ?? '';

  @override
  Future<void> write({required String key, required String value}) async {
    map[key] = value;
  }
}

void main() {
  setUp(() async {
    getIt.reset();
  });

  test('navigates to main when rememberMe is true', () async {
    getIt.registerSingleton<Storage>(
      _FakeStorage({AppConstants.rememberMe: 'true'}),
      instanceName: AppConstants.secureStorage,
    );
    final route = await getInitialRoute();
    expect(route, AppRoutes.mainLayoutRoute);
  });

  test('navigates to sign in when rememberMe is false/empty', () async {
    getIt.registerSingleton<Storage>(
      _FakeStorage({AppConstants.rememberMe: 'false'}),
      instanceName: AppConstants.secureStorage,
    );
    final route = await getInitialRoute();
    expect(route, AppRoutes.signInRoute);
  });
}
