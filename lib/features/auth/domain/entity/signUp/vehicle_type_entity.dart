class VehicleTypeEntity {
  VehicleTypeEntity({required this.id, required this.type});
  final String id;
  final String type;
}

class VehicleTypesResponsEntity {
  VehicleTypesResponsEntity({required this.vehicles});
  final List<VehicleTypeEntity> vehicles;
}
