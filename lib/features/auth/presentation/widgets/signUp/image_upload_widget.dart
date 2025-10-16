import 'package:flowery_tracking/core/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageUploadCustomWidget extends StatelessWidget {
  const ImageUploadCustomWidget({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,

      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(),
            )
          : SvgPicture.asset(Assets.assetsImagesUpload, fit: BoxFit.scaleDown),
    );
  }
}
