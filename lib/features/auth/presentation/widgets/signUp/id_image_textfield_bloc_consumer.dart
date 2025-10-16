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

class IdTextFieldBlocConsumer extends StatelessWidget {
  const IdTextFieldBlocConsumer({
    super.key,
    required this.signUpCubit,
    required this.idImageController,
  });
  final SignUpCubit signUpCubit;
  final TextEditingController idImageController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpCubitState>(
      listener: (context, state) {
        if (state.idImage != null) {
          idImageController.text = state.idImage!.path;
        }
        if (state.aiFailure != null) {
          DialogueUtils.showMessage(
            context: context,
            message: state.aiFailure!.errorMessage,
          );
        }
        if (state.idImageAiResponse == AiResponseType.invalid.name) {
          DialogueUtils.showMessage(
            title: LocaleKeys.error.tr(),
            context: context,
            message: LocaleKeys.invalid_pic_message.tr(),
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              idImageController.clear();
            },
          );
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: idImageController,
          readOnly: true,
          validator: (value) => Validations.photoValidator(value),
          decoration: InputDecoration(
            labelText: LocaleKeys.id_image.tr(),
            hintText: LocaleKeys.upload_id_image.tr(),
            suffixIcon: ImageUploadCustomWidget(
              isLoading: state.aiIdImageLoading,
              onPressed: () => signUpCubit.doIntent(event: ValidateIdLicense()),
            ),
          ),
        );
      },
    );
  }
}
