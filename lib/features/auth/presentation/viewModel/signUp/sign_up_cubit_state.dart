import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signUp/vehicle_type_entity.dart';

class SignUpCubitState extends Equatable {
  const SignUpCubitState({
    this.vehicleLicenseImage,
    this.vehicleLicensePath,
    this.idImage,
    this.idImagePath,
    this.vehicleLicenseImageAiResponse,
    this.idImageAiResponse,
    this.signUpFailure,
    this.aiFailure,
    this.isLoading = false,
    this.aiVehicleLoading = false,
    this.aiIdImageLoading = false,
    this.vehicleList = const [],
  });
  final Failure? signUpFailure;
  final Failure? aiFailure;
  final bool isLoading;
  final bool aiVehicleLoading;
  final bool aiIdImageLoading;
  final List<VehicleTypeEntity>? vehicleList;
  final File? vehicleLicenseImage;
  final File? idImage;
  final String? vehicleLicensePath;
  final String? idImagePath;
  final String? vehicleLicenseImageAiResponse;
  final String? idImageAiResponse;

  SignUpCubitState copyWith({
    final Failure? signUpFailure,
    final Failure? vehicleTypesFailre,
    final bool? isLoading,
    final bool? aiIdImageLoading,
    final bool? aiVehicleLoading,
    final List<VehicleTypeEntity>? vehicleList,
    final File? vehicleLicenseImage,
    final File? idImage,
    final String? vehicleLicensePath,
    final String? idImagePath,
    final String? vehicleLicenseImageAiResponse,
    final String? idImageAiResponse,
    final Failure? aiFailure,
  }) {
    return SignUpCubitState(
      signUpFailure: signUpFailure ?? this.signUpFailure,
      isLoading: isLoading ?? this.isLoading,
      aiVehicleLoading: aiVehicleLoading ?? this.aiVehicleLoading,
      aiIdImageLoading: aiIdImageLoading ?? this.aiIdImageLoading,
      vehicleList: vehicleList ?? this.vehicleList,
      vehicleLicenseImage: vehicleLicenseImage ?? this.vehicleLicenseImage,
      idImage: idImage ?? this.idImage,
      vehicleLicensePath: vehicleLicensePath ?? this.vehicleLicensePath,
      idImagePath: idImagePath ?? this.idImagePath,
      vehicleLicenseImageAiResponse:
          vehicleLicenseImageAiResponse ?? this.vehicleLicenseImageAiResponse,
      idImageAiResponse: idImageAiResponse ?? this.idImageAiResponse,
      aiFailure: aiFailure ?? this.aiFailure,
    );
  }

  @override
  List<Object?> get props => [
        signUpFailure,
        aiFailure,
        isLoading,
        aiVehicleLoading,
        aiIdImageLoading,
        vehicleList,
        vehicleLicenseImage,
        idImage,
        vehicleLicensePath,
        idImagePath,
        vehicleLicenseImageAiResponse,
        idImageAiResponse,
      ];
}