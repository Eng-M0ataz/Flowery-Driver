import 'dart:io';

sealed class ProfileEvents {}

class GetDriverDataEvent extends ProfileEvents {}

class GetAllVehiclesEvent extends ProfileEvents {}

// class EditVehicleEvent extends ProfileEvents {}

// class OnImageSelectedEvent extends ProfileEvents {
//   OnImageSelectedEvent({required this.file});
//   final File file;
// }
//
// class CloseEvent extends ProfileEvents {}
