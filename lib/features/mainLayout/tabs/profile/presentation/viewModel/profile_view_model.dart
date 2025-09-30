import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewModel extends Cubit<ProfileState> {

  ProfileViewModel(
    this._getLoggedUserUseCase,
    this._editVechicalUseCase,
    this._uploadPhotoUseCase
  ) : super(const ProfileState());
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final EditVechicalUseCase _editVechicalUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  final TextEditingController editType = TextEditingController();
  final TextEditingController editNumber = TextEditingController();
  final TextEditingController editLicense = TextEditingController();
  GlobalKey<FormState> editVechicalFormKey = GlobalKey(FormState);

  File? selectedImageFile;
  String? initialImage;

  Future<void> doIntend(ProfileEvent event) async {
    switch(event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
      case EditVechicalEvent():
        await _editVechicalData();
      case OnImageSelectedEvent():
        await _onImageSelected(event.file);
      case CloseEvent():
        _close();
    }
  }
  
  Future<void> _getLoggedUserData() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<LoggedUserDataResponseEntity>():
        final response = result.data;
        _onUserDataLoaded(response);
        emit(state.copyWith(
          isLoading: false,
          failure: null,
          loggedUserDataResponseEntity: response,
        ));

        break;
      case ApiErrorResult<LoggedUserDataResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }
  
  void _onUserDataLoaded(LoggedUserDataResponseEntity response) {
    editType.text = response.user?.vechileType ?? '';
    editNumber.text = response.user?vechial ?? '';
    initialImage = response.user?.photo;
  }
  
  Future<void> _editVechicalData() async {
    if (!_isFormValid()) return;

    emit(state.copyWith(isLoading: true, failure: null, editSuccess: false));

    try {
      final uploadSuccess = await _handleImageUploadIfNeeded();
      if (!uploadSuccess) return;

      await _updateProfileData();
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: null,
        editSuccess: false,
      ));
    }
  }
  
  Future _handleImageUploadIfNeeded() async {
    if (selectedImageFile == null) return true;

    final uploadResult = await _uploadPhotoUseCase.invoke(selectedImageFile!);
    switch (uploadResult) {
      case ApiErrorResult<UploadPhotoResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          failure: uploadResult.failure,
          editSuccess: false,
        ));
        return false;

      case ApiSuccessResult<UploadPhotoResponseEntity>():
        return true;
    }
  }
  
  Future<void> _updateProfileData() async {
    final request = EditProfileRequestEntity(
      firstName: editProfileFirstNameController.text.trim(),
      lastName: editProfileLastNameController.text.trim(),
      email: editProfileEmailController.text.trim(),
      phone: editProfilePhoneController.text
          .replaceAll(RegExp(r'[^\d+]'), '')
          .trim(),
    );

    final result = await _editProfileUseCase.invoke(request);

    switch (result) {
      case ApiSuccessResult<EditProfileResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          editSuccess: true,
          failure: null,
          editProfileResponseEntity: result.data,
        ));
        break;

      case ApiErrorResult<EditProfileResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          failure: result.failure,
          editSuccess: false,
        ));
        selectedImageFile = null;
        break;
    }
  }

}