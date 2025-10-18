import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_image/profile_image_dialog.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/profile/presentation/widgets/profile_image/profile_image_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePickerWidget extends StatefulWidget {
  const ProfileImagePickerWidget({
    super.key,
    this.initialImageUrl,
    this.onImageSelected,
    this.size = AppSizes.icon_120,
  });

  final String? initialImageUrl;
  final Function(File?)? onImageSelected;
  final double size;

  @override
  State<ProfileImagePickerWidget> createState() => _ProfileImagePickerWidgetState();
}

class _ProfileImagePickerWidgetState extends State<ProfileImagePickerWidget> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            child: _selectedImage != null
                ? Image.file(_selectedImage!, fit: BoxFit.cover)
                : (widget.initialImageUrl != null
                      ? Image.network(
                          widget.initialImageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person, size: widget.size / 2)),
          ),
        ),
        GestureDetector(
          onTap: () => showProfileImageDialog(
            context: context,
            onPickImage: _pickImage,
            hasImage: _selectedImage != null || widget.initialImageUrl != null,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingXs_4),
            decoration: BoxDecoration(
              color: AppColorsLight.pink[10],
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: AppSizes.icon_18,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: AppSizes.pickImageWidth,
        maxHeight: AppSizes.pickImageHeight,
        imageQuality: AppConstants.imageQuality,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        widget.onImageSelected?.call(_selectedImage);
      }
    } catch (e) {
      showErrorDialog(
        context,
        LocaleKeys.failed_to_pick_image.tr() + e.toString(),
      );
    }
  }
}
