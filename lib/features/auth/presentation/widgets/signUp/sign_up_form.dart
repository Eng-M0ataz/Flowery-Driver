import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/di/di.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_state.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/country_text_form_field.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/id_image_textfield_bloc_consumer.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/image_text_field_bloc_consumer.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/password_form_filed.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/radio_widget.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/vehicle_type_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

late GlobalKey<FormState> _formKey;
late TextEditingController _firstNameController;
late TextEditingController _lastNameController;
late TextEditingController _VehicleTypeController;
late TextEditingController _VehicleNumberController;
late TextEditingController _vehicleLicenseController;
late TextEditingController _emailController;
late TextEditingController _phoneNumberController;
late TextEditingController _idNumberController;
late TextEditingController _idImageController;
late TextEditingController _passwordController;
late TextEditingController _confirmPasswordController;
late TextEditingController _countryController;
late SignUpCubit _signUpCubit;
late String _countryCode;

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    _signUpCubit = getIt<SignUpCubit>();
    _signUpCubit.doIntent(event: GetVehicleTypes());
    _formKey = GlobalKey<FormState>();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _VehicleTypeController = TextEditingController();
    _VehicleNumberController = TextEditingController();
    _vehicleLicenseController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _idNumberController = TextEditingController();
    _idImageController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _countryController = TextEditingController();
    _countryCode = '';
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController;
    _lastNameController;
    _VehicleTypeController;
    _VehicleNumberController;
    _vehicleLicenseController;
    _emailController;
    _phoneNumberController;
    _idNumberController;
    _idImageController;
    _passwordController;
    _confirmPasswordController;
    _formKey;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _signUpCubit,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Column(
          spacing: AppSizes.spaceBetweenItems_24,
          children: [
            CountryTextFormField(
              onInit: (country) {
                _countryController.text = country!.code!;
                _countryCode = country.dialCode!;
              },
              onChanged: (country) {
                _countryController.text = country.code!;
                _countryCode = country.dialCode!;
              },
            ),
            VehicleTextFieldBlocConsumer(
              signUpCubit: _signUpCubit,
              vehicleLicenseController: _vehicleLicenseController,
            ),
            IdTextFieldBlocConsumer(
              signUpCubit: _signUpCubit,
              idImageController: _idImageController,
            ),
            TextFormField(
              controller: _firstNameController,
              validator: (value) => Validations.validateName(value),
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_first_legal_name.tr(),
                labelText: LocaleKeys.first_legal_name.tr(),
              ),
            ),
            TextFormField(
              controller: _lastNameController,
              validator: (value) => Validations.validateName(value),
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_second_legal_name.tr(),
                labelText: LocaleKeys.second_legal_name.tr(),
              ),
            ),
            VehicleTypeDropdownButtonFormField(
              onChanged: (value) {
                _VehicleTypeController.text = value ?? '';
              },
            ),
            TextFormField(
              controller: _VehicleNumberController,
              validator: (value) => Validations.VehicleNumberValidator(value),
              decoration: InputDecoration(
                labelText: LocaleKeys.vehicle_number.tr(),
                hintText: LocaleKeys.enter_vehicle_number.tr(),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _idNumberController,
              validator: (value) => Validations.egyptianIdValidator(value),
              decoration: InputDecoration(
                labelText: LocaleKeys.id_number.tr(),
                hintText: LocaleKeys.enter_national_id_number.tr(),
              ),
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) => Validations.validateEmail(value),
              decoration: InputDecoration(
                labelText: LocaleKeys.email.tr(),
                hintText: LocaleKeys.enter_your_email.tr(),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              validator: (value) => Validations.validatePhoneNumber(value),
              decoration: InputDecoration(
                labelText: LocaleKeys.phone_number.tr(),
                hintText: LocaleKeys.enter_phone_number.tr(),
              ),
            ),
            CustomPasswordTextFormField(
              controller: _passwordController,
              validator: (value) => Validations.validatePassword(value),
              label: LocaleKeys.password.tr(),
              hint: LocaleKeys.enter_password.tr(),
            ),
            CustomPasswordTextFormField(
              controller: _confirmPasswordController,
              validator: (value) => Validations.validateConfirmPassword(
                value,
                _passwordController.text,
              ),
              label: LocaleKeys.confirm_password.tr(),
              hint: LocaleKeys.confirm_password.tr(),
            ),
            const RadioWidget(),
            BlocConsumer<SignUpCubit, SignUpCubitState>(
              listener: (context, state) {
                if (state.signUpFailure != null) {
                  DialogueUtils.showMessage(
                    context: context,
                    message: state.signUpFailure!.errorMessage,
                  );
                }
              },
              builder: (context, state) => CustomElevatedButton(
                isLoading: state.isLoading,
                widget: Text(LocaleKeys.continue_text.tr()),
                onPressed: () async {
                  final signUpRequest = SignUpRequestModel(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    phoneNumber: (_countryCode + _phoneNumberController.text),
                    country: _countryController.text,
                    vehicleType: _VehicleTypeController.text,
                    vehicleNumber: _VehicleNumberController.text,
                    nationalId: _idNumberController.text,
                    nationalIdImage: _idImageController.text,
                    vehicleLicenseImage: _vehicleLicenseController.text,
                    confirmPassword: _confirmPasswordController.text,
                    gender: RadioWidget.groupValueNotifier.value,
                  );

                  if (_formKey.currentState!.validate()) {
                    _signUpCubit.doIntent(
                      event: SignUpEvent(),
                      signUpRequest: signUpRequest,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
