class DriverEntity {

  DriverEntity ({
    required this.role,
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nID,
    required this.nIDImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.createdAt,
  });

  final String role;
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  final String nID;
  final String nIDImg;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String createdAt;
}