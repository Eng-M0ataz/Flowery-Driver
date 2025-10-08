import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = true,
    this.failure,
    this.driverProfileResponseEntity,
    this.editProfileResponseEntity,
    this.selectedImage,
    this.editSuccess = false,
  });

  final bool isLoading;
  final Failure? failure;
  final DriverProfileResponseEntity? driverProfileResponseEntity;
  final EditProfileResponseEntity? editProfileResponseEntity;
  final File? selectedImage;
  final bool editSuccess;

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    driverProfileResponseEntity,
    editProfileResponseEntity,
    selectedImage,
    editSuccess,
  ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    DriverProfileResponseEntity? driverProfileResponseEntity,
    EditProfileResponseEntity? editProfileResponseEntity,
    File? selectedImage,
    bool? editSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      driverProfileResponseEntity:
      driverProfileResponseEntity ?? this.driverProfileResponseEntity,
      editProfileResponseEntity: editProfileResponseEntity ?? this.editProfileResponseEntity,
      selectedImage: selectedImage ?? this.selectedImage,
      editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
