import 'dart:io';

import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/response/edit_vechical_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';

class ProfileState {
  const ProfileState({
    this.isLoading = true,
    this.failure,
    this.loggedUserDataResponseEntity,
    this.editVechicalResponseEntity,
    this.licenseImage,
    this.editSuccess = false,
  });
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;
  final EditVechicalResponseEntity? editVechicalResponseEntity;
  final File? licenseImage;
  final bool editSuccess;

  List<Object?> get props => [
    isLoading,
    failure,
    loggedUserDataResponseEntity,
    editVechicalResponseEntity,
    licenseImage,
    editSuccess,
  ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
    EditVechicalResponseEntity? editVechicalResponseEntity,
    File? licenseImage,
    bool? editSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
      editVechicalResponseEntity:
          editVechicalResponseEntity ?? this.editVechicalResponseEntity,
      licenseImage: licenseImage ?? this.licenseImage,
      editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
