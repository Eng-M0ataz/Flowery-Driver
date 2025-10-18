import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_image/profile_image_utils.dart';

void showProfileImageDialog({
  required BuildContext context,
  required Function(ImageSource source) onPickImage,
  required bool hasImage,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColorsLight.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.borderRadiusXl_20)),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_20),
                child: Column(
                  children: [
                    buildHandleBar(),
                    const SizedBox(height: AppSizes.spaceBetweenItems_20),
                    Text(
                      LocaleKeys.select_profile_picture.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPickerOption(
                          context: context,
                          icon: Icons.camera_alt,
                          label: LocaleKeys.camera.tr(),
                          onTap: () => onPickImage(ImageSource.camera),
                        ),
                        buildPickerOption(
                          context: context,
                          icon: Icons.photo_library,
                          label: LocaleKeys.gallery.tr(),
                          onTap: () => onPickImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBetweenItems_20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
