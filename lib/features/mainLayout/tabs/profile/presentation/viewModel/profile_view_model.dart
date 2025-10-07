import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_profile_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/use_cases/get_logged_user_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class ProfileViewModel extends Cubit<ProfileState>{
  ProfileViewModel(this._getLoggedUserUseCase):super(const ProfileState());
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  Future<void> doIntend(ProfileEvent event)async {
    switch (event) {
      case GetLoggedDriverDataEvent():
        await _getLoggedDriverData();
      case LoadDriverDataEvent():
        await _getLoggedDriverData();
    }
  }

  Future<void> _getLoggedDriverData() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getLoggedUserUseCase();
    switch (result) {
      case ApiSuccessResult<DriverProfileResponseEntity>():
        final response = result.data;
        emit(state.copyWith(
          isLoading: false,
          failure: null,
          driverProfileResponseEntity: response,
        ));
        break;
      case ApiErrorResult<DriverProfileResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }
}