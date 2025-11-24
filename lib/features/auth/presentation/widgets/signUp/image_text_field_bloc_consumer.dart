import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/enum/ai_response_type.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_events.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/signUp/sign_up_cubit_state.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/image_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleTextFieldBlocConsumer extends StatelessWidget {
  const VehicleTextFieldBlocConsumer({
    super.key,
    required this.signUpCubit,
    required this.vehicleLicenseController,
  });

  final SignUpCubit signUpCubit;
  final TextEditingController vehicleLicenseController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpCubitState>(
      listenWhen: (p, c) =>
          p.idImage != c.idImage ||
          p.aiFailure != c.aiFailure ||
          p.idImageAiResponse != c.idImageAiResponse ||
          p.aiSuc != c.aiSuc,
      listener: (context, state) {
        if (state.vehicleLicenseImage != null) {
          vehicleLicenseController.text = state.vehicleLicenseImage!.path;
        }
        if (state.aiFailure != null && !state.aiSuc) {
          DialogueUtils.showMessage(
            context: context,
            message: state.aiFailure!.errorMessage,
          );
        }
        if (state.vehicleLicenseImageAiResponse ==
                AiResponseType.invalid.name &&
            state.aiSuc) {
          DialogueUtils.showMessage(
            title: LocaleKeys.error.tr(),
            context: context,
            message: LocaleKeys.invalid_pic_message.tr(),
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              vehicleLicenseController.clear();
            },
          );
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: vehicleLicenseController,
          readOnly: true,
          validator: (value) => Validations.photoValidator(value),
          decoration: InputDecoration(
            labelText: LocaleKeys.vehicle_license.tr(),
            hintText: LocaleKeys.upload_license_photo.tr(),
            suffixIcon: ImageUploadCustomWidget(
              isLoading: state.aiVehicleLoading,
              onPressed: () =>
                  signUpCubit.doIntent(event: ValidateVehicleLicense()),
            ),
          ),
        );
      },
    );
  }
}
