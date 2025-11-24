import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInViewModel extends Cubit<SignInState> {
  SignInViewModel(this._signInUseCase) : super(SignInState());
  final SignInUseCase _signInUseCase;



  void doIntent({required SignInEvents event}) async {
    switch (event) {
      case SignInEvent():
        await _signIn(event.email, event.password);
      case TogglePasswordEvent():
        _togglePasswordVisibility();
      case ToggleRememberMeEvent():
        _toggleRememberMe(event.isRememberMe);
      case NavigationEvent():
        _navigateToRouteScreen(event.context, event.appRoute);
    }
  }

  Future<void> _signIn(String email, String password) async {
    emit(state.copyWith(isLoading: true));
    final result = await _signInUseCase.invoke(
      requestEntity: SignInRequestEntity(email: email, password: password),
      rememberMeChecked: state.isRememberMe,
    );

    switch (result) {
      case ApiSuccessResult<SignInResponseEntity>():
        emit(
          state.copyWith(response: result.data, isLoading: false, isSuc: true),
        );
      case ApiErrorResult<SignInResponseEntity>():
        emit(
          state.copyWith(
            failure: result.failure,
            isLoading: false,
            isSuc: false,
          ),
        );
    }
  }

  _navigateToRouteScreen(BuildContext context, String appRoute) {
    context.pushNamed(appRoute);
  }

  void _togglePasswordVisibility() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void _toggleRememberMe(bool value) {
    emit(state.copyWith(isRememberMe: value));
  }
}
