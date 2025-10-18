import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/driver_data_entity.dart';

class DriverResponseEntity {
  const DriverResponseEntity({this.message, this.driver});

  final String? message;
  final DriverEntity? driver;
}
