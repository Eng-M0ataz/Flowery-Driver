import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/domain/entity/driver_profile_response_entity.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.isLoading = true,
    this.failure,
    this.driverProfileResponseEntity,
  });

  final bool isLoading;
  final Failure? failure;
  final DriverProfileResponseEntity? driverProfileResponseEntity;

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    driverProfileResponseEntity,
  ];

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    DriverProfileResponseEntity? driverProfileResponseEntity,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      driverProfileResponseEntity:
      driverProfileResponseEntity ?? this.driverProfileResponseEntity,
    );
  }
}
