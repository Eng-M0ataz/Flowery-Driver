import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/core/widgets/custom_app_bar.dart';
import 'package:flowery_tracking/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController firstNameController = TextEditingController(
    text: 'Abdelrahman',
  );
  final TextEditingController lastNameController = TextEditingController(
    text: 'Youssef',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'matrix511997@gmail.com',
  );
  final TextEditingController phoneNumberController = TextEditingController(
    text: '01155704252',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '01155704252',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.editProfile.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd_16,
            ),
            child: Form(
              child: AutofillGroup(
                child: Column(
                  spacing: AppSizes.spaceBetweenItems_24,
                  children: [
                    Stack(
                      alignment: AlignmentGeometry.bottomRight,
                      children: [
                        Container(
                          width: AppSizes.profileImageSize_85,
                          height: AppSizes.profileImageSize_85,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColorsLight.black,
                              width: AppSizes.borderWidth_2,
                            ),
                          ),
                          child: ClipOval(
                            child: SvgPicture.asset(
                              Assets.assetsImagesPersonUnselected,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.paddingXs_4),
                            decoration: BoxDecoration(
                              color: AppColorsLight.pink[10],
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadiusSm_4,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: AppSizes.icon_18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: AppSizes.spaceBetweenItems_16,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                            validator: (name) => Validations.validateName(name),
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
                            validator: (name) => Validations.validateName(name),
                            controller: lastNameController,
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
                      validator: (email) => Validations.validateEmail(email),
                      controller: emailController,
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
                      controller: phoneNumberController,
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
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (password) =>
                          Validations.validatePassword(password),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.password],
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: LocaleKeys.password.tr(),
                        labelText: LocaleKeys.password.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: TextButton(
                          onPressed: () {},
                          child: Text(LocaleKeys.change.tr(), style: Theme.of(context).textTheme.titleMedium),
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
                        GenderOption(value: 'male', groupValue: 'male', label: 'male', activeColor: AppColorsLight.pink),
                        const SizedBox(width: AppSizes.paddingMd_20),
                        GenderOption(value: 'female', groupValue: 'male', label: 'female', activeColor: AppColorsLight.grey),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_50,),
                    CustomElevatedButton(
                      onPressed: () {},
                      isLoading: false,
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
  }
}


class GenderOption extends StatelessWidget {

  const GenderOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.activeColor,
  });
  final String value;
  final String groupValue;
  final String label;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: null,
          activeColor: activeColor,
          fillColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
              if (value == groupValue) {
                return activeColor;
              }
              return Colors.grey;
            },
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}