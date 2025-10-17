abstract interface class RealTimeDataBaseService {
  Future<Map<String, dynamic>?> read(String path);

  Future<void> create(String path, Map<String, dynamic> data);

  Future<void> update(String path, Map<String, dynamic> data);

  Future<void> delete(String path);

  Stream<Map<String, dynamic>> listenData(String path);
}
