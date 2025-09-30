import 'dart:io';

class EditVechicalResponseEntity {
  EditVechicalResponseEntity({
    required this.vechicalType,
    required this.vechicalNumber,
    required this.vechicalLicense,
  });
  final String? vechicalType;
  final String? vechicalNumber;
  final File? vechicalLicense;
}
