import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/meta_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/vehicles_entity.dart';

class GetAllVehiclesResponseEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<VehicleEntity>? vehicles;

  GetAllVehiclesResponseEntity ({
    this.message,
    this.metadata,
    this.vehicles,
  });
}


