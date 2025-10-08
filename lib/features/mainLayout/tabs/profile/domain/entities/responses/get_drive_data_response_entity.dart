import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/driver_data_entity.dart';

class GetDriverDataResponseEntity {
  final String? message;
  final DriverDataEntity? driver;

  GetDriverDataResponseEntity ({
    this.message,
    this.driver,
  });
}
