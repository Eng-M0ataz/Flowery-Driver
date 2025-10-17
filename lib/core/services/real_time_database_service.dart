abstract class RealTimeDataBaseService {
  Future<void> create(String path, dynamic data);

  Future<dynamic> read(String path);

  Future<void> update(String path, Map<String, dynamic> data);

  Future<void> delete(String path);

  Stream<dynamic> listenData(String path);

  Future<void> pushToList(String path, dynamic data);
}