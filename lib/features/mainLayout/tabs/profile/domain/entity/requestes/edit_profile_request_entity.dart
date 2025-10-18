class EditProfileRequestEntity {
  EditProfileRequestEntity({
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.phone,
    required this.gender,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
}
