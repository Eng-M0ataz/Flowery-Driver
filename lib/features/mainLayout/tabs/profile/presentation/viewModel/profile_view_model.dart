import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_all_vehicles_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/responses/get_drive_data_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entities/vehicles_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/useCases/get_all_vehicles_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/useCases/get_driver_data_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel(
      this._getDriverDataUseCase,
      this._getAllVehiclesUseCase,
      ) : super(ProfileState());
  final GetDriverDataUseCase _getDriverDataUseCase;
  final GetAllVehiclesUseCase _getAllVehiclesUseCase;

  Future<void> doIntend(ProfileEvents events) async {
    switch (events){

      case GetDriverDataEvent():
        await _getDriverData();
      case GetAllVehiclesEvent():
        await _getAllVehicles();
    }
  }

  Future<void> _getDriverData() async {
    final result = await _getDriverDataUseCase.getDriverData();
    switch(result){

      case ApiSuccessResult<GetDriverDataResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          getDriverDataResponseEntity: result.data
        ));
        break;
      case ApiErrorResult<GetDriverDataResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          failure: result.failure
        ));
    }
  }

  Future<void> _getAllVehicles() async {
    final result = await _getAllVehiclesUseCase.getAllVehicles();
    switch(result){

      case ApiSuccessResult<GetAllVehiclesResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          getAllVehiclesResponseEntity: result.data
        ));
      case ApiErrorResult<GetAllVehiclesResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          failure: result.failure
        ));
    }
  }

  String? getDriverVehicleNameById(String? vehicleId, List<VehicleEntity>? vehicles) {
    return vehicles
        ?.firstWhere(
          (v) => v.Id == vehicleId,
      orElse: () => VehicleEntity(Id: '-1', type: 'Unknown'),
    )
        .type;
  }

}