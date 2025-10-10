import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/helpers/routing_extensions.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/viewModel/profile_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/edit_profile_widgets/gender_option.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/edit_profile_widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    viewModel = context.read<ProfileViewModel>();
    viewModel.doIntend(LoadDriverDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.doIntend(CloseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: LocaleKeys.editProfile.tr()),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMd_16,
                ),
                child: Form(
                  key: viewModel.editProfileFormKey,
                  child: AutofillGroup(
                    child: Column(
                      spacing: AppSizes.spaceBetweenItems_24,
                      children: [
                        ProfileImagePickerWidget(
                          initialImageUrl:
                              state.selectedImage?.path ??
                              viewModel.initialImage,
                          onImageSelected: (image) {
                            if (image != null) {
                              viewModel.doIntend(
                                OnImageSelectedEvent(file: image),
                              );
                            }
                          },
                        ),
                        Row(
                          spacing: AppSizes.spaceBetweenItems_16,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: viewModel.firstNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.name],
                                validator: (name) =>
                                    Validations.validateName(name),
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.firstName.tr(),
                                  labelText: LocaleKeys.firstName.tr(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (name) =>
                                    Validations.validateName(name),
                                controller: viewModel.lastNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.name],
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.lastName.tr(),
                                  labelText: LocaleKeys.lastName.tr(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          validator: (email) =>
                              Validations.validateEmail(email),
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            hintText: LocaleKeys.email.tr(),
                            labelText: LocaleKeys.email.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        TextFormField(
                          validator: (phone) =>
                              Validations.validatePhoneNumber(phone),
                          controller: viewModel.phoneNumberController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          decoration: InputDecoration(
                            hintText: LocaleKeys.phoneNumber.tr(),
                            labelText: LocaleKeys.phoneNumber.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: TextEditingController(
                            text: AppConstants.passwordCharacters,
                          ),
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.password],
                          decoration: InputDecoration(
                            hintText: LocaleKeys.password.tr(),
                            labelText: LocaleKeys.password.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: TextButton(
                              onPressed: () {},
                              child: Text(
                                LocaleKeys.change.tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.gender,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(width: AppSizes.paddingMd_20),
                            GenderOption(
                              value: AppConstants.female,
                              groupValue:
                                  state
                                      .driverProfileResponseEntity
                                      ?.driver
                                      ?.gender ??
                                  AppConstants.male,
                              label: LocaleKeys.female_label.tr(),
                              activeColor: AppColorsLight.pink,
                            ),
                            const SizedBox(width: AppSizes.paddingMd_20),
                            GenderOption(
                              value: AppConstants.male,
                              groupValue:
                                  state
                                      .driverProfileResponseEntity
                                      ?.driver
                                      ?.gender ??
                                  AppConstants.male,
                              label: LocaleKeys.male_label.tr(),
                              activeColor: AppColorsLight.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceBetweenItems_50),
                        CustomElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            viewModel.doIntend(EditProfileSubmitEvent());
                          },
                          isLoading: state.isLoading,
                          widget: Text(LocaleKeys.update.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.failure != null && !state.isLoading) {
          DialogueUtils.showMessage(
            context: context,
            message: state.failure!.errorMessage,
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              viewModel.doIntend(ResetSuccessStateEvent());
              context.pop();
            },
          );
        }

        if (state.editSuccess && !state.isLoading) {
          DialogueUtils.showMessage(
            context: context,
            message: LocaleKeys.profile_updated.tr(),
            title: LocaleKeys.success.tr(),
            posActionName: LocaleKeys.ok.tr(),
            posAction: () {
              viewModel.doIntend(ResetSuccessStateEvent());
              Navigator.of(context).pop(true);

            },
          );
        }
      },
    );
  }
}
