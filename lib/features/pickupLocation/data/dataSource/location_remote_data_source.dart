abstract interface class LocationRemoteDataSource{
  Stream<dynamic> listenData(String path);
}