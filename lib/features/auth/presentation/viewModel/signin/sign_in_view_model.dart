import 'package:bloc/bloc.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signin/sign_in_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class SignInViewModel extends Cubit<SignInStates>{
  SignInViewModel(this._signInUseCase) : super(SignInInitState());
  final SignInUseCase _signInUseCase;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: 'abdoaswani@gmail.com');
  TextEditingController passwordController = TextEditingController(text: 'Ahmed@123');
  bool rememberMe = false;
  static SignInViewModel get(context) => BlocProvider.of<SignInViewModel>(context);

  Future<void> signIn() async {
    if(formKey.currentState!.validate()){
      emit(SignInLoadingState());
      final result = await _signInUseCase.call(
        requestEntity: SignInRequestEntity(
          email: emailController.text,
          password: passwordController.text,
        ),
        rememberMeChecked: rememberMe,
      );
      switch(result){
        case ApiSuccessResult<SignInResponseEntity>():
          emit(SignInSuccessState(result.data));
        case ApiErrorResult<SignInResponseEntity>():
          emit(SignInErrorState(result.failure.errorMessage));
      }
    }
  }
}