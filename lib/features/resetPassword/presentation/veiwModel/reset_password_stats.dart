import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.isLoading = false,
    this.failure,
    this.resetPasswordSuccess = false,
  });
  final bool isLoading;
  final Failure? failure;
  final bool resetPasswordSuccess;

  ResetPasswordState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? resetPasswordSuccess,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      resetPasswordSuccess: resetPasswordSuccess ?? this.resetPasswordSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, resetPasswordSuccess];
}
