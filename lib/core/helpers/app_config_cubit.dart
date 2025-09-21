import 'dart:ui';

import 'package:flowery_tracking/core/services/storage_interface.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppConfigCubit extends Cubit<Locale> {
  AppConfigCubit(@Named(AppConstants.secureStorage) this._storage)
    : super(const Locale(AppConstants.en));
  final Storage _storage;

  Future<void> loadSavedLocale() async {
    final code = await _storage.read(key: AppConstants.languageCode);
    if (code.isNotEmpty) {
      emit(Locale(code));
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    await _storage.write(
      key: AppConstants.languageCode,
      value: locale.languageCode,
    );
    emit(locale);
  }
}
