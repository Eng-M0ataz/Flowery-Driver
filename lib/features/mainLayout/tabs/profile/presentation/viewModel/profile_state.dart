import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';

class ProfileState {
  const ProfileState({
    this.isLoading = true,
    this.failure,
    this.getDriverDataResponseEntity,
    this.getAllVehiclesResponseEntity,
    this.selectedVehicle,
    // this.editVehicleRequestEntity,
    // this.editVehicleResponseEntity,
    // this.licenseImage,
    // this.editSuccess = false,
  });
  final bool isLoading;
  final Failure? failure;
  final String? selectedVehicle;
  final GetDriverDataResponseEntity? getDriverDataResponseEntity;
  final GetAllVehiclesResponseEntity? getAllVehiclesResponseEntity;
  // final EditVehicleRequestEntity? editVehicleRequestEntity;
  // final EditVehicleResponseEntity? editVehicleResponseEntity;
  // final File? licenseImage;
  // final bool editSuccess;

  List<Object?> get props => [
    isLoading,
    failure,
    getDriverDataResponseEntity,
    getAllVehiclesResponseEntity,
    selectedVehicle,
    // editVehicleRequestEntity,
    // editVehicleResponseEntity,
    // licenseImage,
    // editSuccess,
  ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    GetDriverDataResponseEntity? getDriverDataResponseEntity,
    GetAllVehiclesResponseEntity? getAllVehiclesResponseEntity,
    String? selectedVehicle,
    // EditVehicleRequestEntity? editVehicleRequestEntity,
    // EditVehicleResponseEntity? editVehicleResponseEntity,
    // File? licenseImage,
    // bool? editSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      getDriverDataResponseEntity:
      getDriverDataResponseEntity ?? this.getDriverDataResponseEntity,
      getAllVehiclesResponseEntity:
        getAllVehiclesResponseEntity ?? this.getAllVehiclesResponseEntity,
      // editVehicleRequestEntity:
      //     editVehicleRequestEntity ?? this.editVehicleRequestEntity,
      // editVehicleResponseEntity:
      //     editVehicleResponseEntity ?? this.editVehicleResponseEntity,
      // licenseImage: licenseImage ?? this.licenseImage,
      // editSuccess: editSuccess ?? this.editSuccess,
    );
  }
}
