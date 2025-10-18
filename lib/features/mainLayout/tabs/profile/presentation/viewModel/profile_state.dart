import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = false,
    this.failure,
    this.driverProfileResponseEntity,
    this.editProfileResponseEntity,
    this.vehicleResponseEntity,
    this.selectedImage,
    this.editSuccess = false,
  });

  final bool isLoading;
  final Failure? failure;
  final DriverProfileResponseEntity? driverProfileResponseEntity;
  final EditProfileResponseEntity? editProfileResponseEntity;
  final VehicleResponseEntity? vehicleResponseEntity;
  final File? selectedImage;
  final bool editSuccess;

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    driverProfileResponseEntity,
    editProfileResponseEntity,
    vehicleResponseEntity,
    selectedImage,
    editSuccess,
  ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    DriverProfileResponseEntity? driverProfileResponseEntity,
    EditProfileResponseEntity? editProfileResponseEntity,
    VehicleResponseEntity? vehicleResponseEntity,
    File? selectedImage,
    bool? editSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      driverProfileResponseEntity:
      driverProfileResponseEntity ?? this.driverProfileResponseEntity,
      vehicleResponseEntity: vehicleResponseEntity ?? this.vehicleResponseEntity,
      editProfileResponseEntity: editProfileResponseEntity ?? this.editProfileResponseEntity,
      selectedImage: selectedImage ?? this.selectedImage,
      editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
