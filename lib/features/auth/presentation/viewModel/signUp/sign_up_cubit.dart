import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flowery_tracking/core/aiLayer/domain/useCases/validate_data_use_case.dart';
import 'package:flowery_tracking/core/enum/driver_image_type.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/functions/image_picker.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_local_vehicle_types_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/get_vehicles_use_case.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpCubit extends Cubit<SignUpCubitState> {
  SignUpCubit(
    this._signUpUseCase,
    this._validateDataUseCase,
    this._getVehicleTypesUseCase,
    this._getLocalVehicleTypesUseCase,
  ) : super(const SignUpCubitState());

  final SignUpUseCase _signUpUseCase;
  final GetVehicleTypesUseCase _getVehicleTypesUseCase;
  final ValidateDataUseCase _validateDataUseCase;
  final GetLocalVehicleTypesUseCase _getLocalVehicleTypesUseCase;

  void doIntent({
    required SignUpCubitEvents event,
    SignUpRequestModel? signUpRequest,
  }) async {
    switch (event) {
      case SignUpEvent():
        await _signUp(signUpRequest!);
      case ValidateVehicleLicense():
        await _pickAndValidateVehicleLicense();

      case GetVehicleTypes():
        await _getVehicleTypes();
      case ValidateIdLicense():
        await _pickAndValidateIdImage();
    }
  }

  Future<void> _signUp(SignUpRequestModel signUpRequest) async {
    emit(state.copyWith(isLoading: true));
    final result = await _signUpUseCase.invoke(signUpRequest);
    switch (result) {
      case ApiSuccessResult<void>():
        emit(state.copyWith(isLoading: false));
      case ApiErrorResult<void>():
        emit(state.copyWith(signUpFailure: result.failure, isLoading: false));
    }
  }

  Future<void> _getVehicleTypes() async {
    final result = await _getVehicleTypesUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<VehicleTypesResponsEntity>():
        emit(state.copyWith(vehicleList: result.data.vehicles));
      case ApiErrorResult<VehicleTypesResponsEntity>():
        final result = await _getLocalVehicleTypes();
        emit(state.copyWith(vehicleList: result.vehicles));
    }
  }

  Future<VehicleTypesResponsEntity> _getLocalVehicleTypes() async {
    return await _getLocalVehicleTypesUseCase.invoke();
  }

  Future<File?> _pickImage() async {
    final data = await FromFlutterDocScannerPackage().pickImage();
    if (data is String) {
      return null;
    } else {
      return _extractImageFileFromScannerResult(data);
    }
  }

  File _extractImageFileFromScannerResult(data) {
    final String takenImges = data['Uri'];
    final StartIndex = takenImges.indexOf('/data');
    final EndIndex = takenImges.indexOf('}');
    final cleanImage = takenImges.substring(StartIndex, EndIndex);
    return File(cleanImage);
  }

  Future<void> _validateUserImage({
    required AiImageType type,
    required Uint8List data,
  }) async {
    emit(_setLoading(true, type));
    final result = await _validateDataUseCase.invoke(
      prompt: AppConstants.aiValidationPrompt,
      data: data,
      dataType: AppConstants.imageDataType,
    );
    emit(_setLoading(false, type));
    switch (result) {
      case ApiSuccessResult<String>():
        emit(_setResponse(result.data, type));

      case ApiErrorResult<String>():
        emit(state.copyWith(aiFailure: result.failure));
    }
  }

  Future<void> _pickAndValidateVehicleLicense() async {
    final File? imageFile = await _pickImage();

    if (imageFile != null) {
      final data = await imageFile.readAsBytes();
      await _validateUserImage(data: data, type: AiImageType.vehicleLicense);
      if (state.vehicleLicenseImageAiResponse == 'VALID') {
        emit(state.copyWith(vehicleLicenseImage: imageFile));
      }
    }
  }

  Future<void> _pickAndValidateIdImage() async {
    final File? imageFile = await _pickImage();

    if (imageFile != null) {
      final data = await imageFile.readAsBytes();
      await _validateUserImage(data: data, type: AiImageType.idCard);
      if (state.idImageAiResponse == 'VALID') {
        emit(state.copyWith(idImage: imageFile));
      }
    }
  }

  SignUpCubitState _setLoading(bool value, AiImageType type) {
    switch (type) {
      case AiImageType.vehicleLicense:
        return state.copyWith(aiVehicleLoading: value);
      case AiImageType.idCard:
        return state.copyWith(aiIdImageLoading: value);
    }
  }

  SignUpCubitState _setResponse(String data, AiImageType type) {
    switch (type) {
      case AiImageType.vehicleLicense:
        return state.copyWith(vehicleLicenseImageAiResponse: data);
      case AiImageType.idCard:
        return state.copyWith(idImageAiResponse: data);
    }
  }
}
