import 'dart:io';

import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/edit_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/upload_photo_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/Responses/vehicle_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/requestes/edit_profile_request_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_vehicle_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/upload_photo_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel(this._getVehicleUseCase,
      this._getLoggedUserUseCase,
      this._editProfileUseCase,
      this._uploadPhotoUseCase,) : super(const ProfileState());
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final GetVehicleUseCase _getVehicleUseCase;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  File? selectedImageFile;
  String? initialImage;

  Future<void> doIntend(ProfileEvent event) async {
    switch (event) {
      case GetLoggedDriverDataEvent():
        await _getLoggedDriverData();
      case LoadDriverDataEvent():
        await _getLoggedDriverData();
      case EditProfileSubmitEvent():
        await _updateProfileWithOptionalImage();
      case OnImageSelectedEvent():
        _onImageSelected(event.file);
        break;
      case ResetSuccessStateEvent():
        _resetSuccessState();
      case CloseEvent():
        _close();
    }
  }

  Future<void> _getLoggedDriverData() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<DriverProfileResponseEntity>():
        final response = result.data;
        _onDriverDataLoaded(response);
        await getVehicle(response.driver.vehicleType);
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            driverProfileResponseEntity: response,
            vehicleResponseEntity: state.vehicleResponseEntity,
          ),
        );
        break;
      case ApiErrorResult<DriverProfileResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  Future<void> getVehicle(String vehicleId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getVehicleUseCase(vehicleId);
    switch (result) {
      case ApiSuccessResult<VehicleResponseEntity>():
        final response = result.data;
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            vehicleResponseEntity: response,
          ),
        );
        break;
      case ApiErrorResult<VehicleResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  void _onDriverDataLoaded(DriverProfileResponseEntity response) {
    firstNameController.text = response.driver.firstName;
    lastNameController.text = response.driver.lastName;
    emailController.text = response.driver.email;
    phoneNumberController.text = response.driver.phone;
    initialImage = response.driver.photo;
  }

  Future<void> _updateProfileWithOptionalImage() async {
    if (!_isFormValid()) return;

    emit(state.copyWith(isLoading: true, failure: null, editSuccess: false));

    try {
      final uploadSuccess = await _handleImageUploadIfNeeded();
      if (!uploadSuccess) return;
      await _updateProfileData();
    } catch (e) {
      emit(state.copyWith(isLoading: false, failure: null, editSuccess: false));
    }
  }

  Future<bool> _handleImageUploadIfNeeded() async {
    if (selectedImageFile == null) return true;

    final uploadResult = await _uploadPhotoUseCase.call(selectedImageFile!);
    switch (uploadResult) {
      case ApiErrorResult<UploadPhotoResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: uploadResult.failure,
            editSuccess: false,
          ),
        );
        return false;

      case ApiSuccessResult<UploadPhotoResponseEntity>():
        return true;
    }
  }

  Future<void> _updateProfileData() async {
    final request = EditProfileRequestEntity(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneNumberController.text
          .replaceAll(RegExp(r'[^\d+]'), '')
          .trim(), gender: '',
    );

    final result = await _editProfileUseCase.call(request);

    switch (result) {
      case ApiSuccessResult<EditProfileResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            editSuccess: true,
            failure: null,
            editProfileResponseEntity: result.data,
          ),
        );
        break;

      case ApiErrorResult<EditProfileResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
            editSuccess: false,
          ),
        );
        selectedImageFile = null;
        break;
    }
  }

  void _onImageSelected(File file) {
    selectedImageFile = file;
    emit(state.copyWith(selectedImage: file));
  }

  bool _isFormValid() {
    return editProfileFormKey.currentState?.validate() ?? false;
  }

  void _resetSuccessState() {
    emit(state.copyWith(editSuccess: false, failure: null));
  }

  Future<void> _close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    return super.close();
  }
}
