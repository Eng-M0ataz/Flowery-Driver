import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/upload_vehicle_license_entity.dart';

class EditVehicleRequestEntity {
  EditVehicleRequestEntity({
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
  });
  final String? vehicleType;
  final String? vehicleNumber;
  final UploadVehicleLicenseEntity? vehicleLicense;
}
