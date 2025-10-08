import 'dart:io';
import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

Widget buildPlaceholder(double size) {
  return Container(
    color: AppColorsLight.white[70],
    child: Icon(
      Icons.person,
      size: size * 0.5,
      color: AppColorsLight.white[90],
    ),
  );
}

Widget buildProfileImage(widget, File? selectedImage) {
  if (selectedImage != null) {
    return Image.file(
      selectedImage,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
    );
  } else if (widget.initialImageUrl != null &&
      widget.initialImageUrl!.isNotEmpty) {
    return Image.network(
      widget.initialImageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null,
            strokeWidth: AppSizes.borderWidth_2,
          ),
        );
      },
    );
  }
  return buildPlaceholder(widget.size);
}

Widget buildCameraIcon() {
  return SvgPicture.asset(
    Assets.assetsImagesCamera,
    width: AppSizes.icon_24,
    height: AppSizes.icon_24,
  );
}

Widget buildPickerOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color? color,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
      Navigator.pop;
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSizes.icon_64,
          height: AppSizes.icon_64,
          decoration: BoxDecoration(
            color: (color ?? AppColorsLight.pink).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon,
              size: AppSizes.icon_30, color: color ?? AppColorsLight.pink),
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? AppColorsLight.black[90],
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    ),
  );
}

Widget buildHandleBar() {
  return Container(
    width: AppSizes.imageHandlerBarWidth,
    height: AppSizes.imageHandlerBarHeight,
    decoration: BoxDecoration(
      color: AppColorsLight.white[40],
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXs_2),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  DialogueUtils.showMessage(
      context: context,
      message: message,
      posActionName: LocaleKeys.ok.tr(),
      posAction: () {
        Navigator.of(context).pop();
      },
      title: LocaleKeys.error.tr());
}
