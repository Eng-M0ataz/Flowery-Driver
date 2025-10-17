import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RealTimeDataBaseService)
@Named(AppConstants.firebaseRealTimeDatabase)
class FirebaseRealTimeDatabaseService implements RealTimeDataBaseService {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  @override
  Future<void> create(String path, dynamic data) async {
    await _ref.child(path).set(data);
  }

  @override
  Future<void> delete(String path) async {
    await _ref.child(path).remove();
  }

  @override
  Future<dynamic> read(String path) async {
    final snapshot = await _ref.child(path).get();
    return snapshot.value;
  }

  @override
  Future<void> update(String path, Map<String, dynamic> data) async {
    await _ref.child(path).update(data);
  }

  @override
  Stream<dynamic> listenData(String path) {
    return _ref.child(path).onValue.map((event) {
      return event.snapshot.value;
    });
  }

  @override
  Future<void> pushToList(String path, dynamic data) async {
    await _ref.child(path).push().set(data);
  }
}