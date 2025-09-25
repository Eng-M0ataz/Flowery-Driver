import 'package:flowery_tracking/core/config/theme/app_colors.dart';
import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

abstract class DialogueUtils {
  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? ngeActionName,
    Function? ngeAction,
  })
  {
    final List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName),
        ),
      );
    }
    if (ngeActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ngeAction?.call();
          },
          child: Text(ngeActionName),
        ),
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: actions,
          content: Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: Colors.black),
          ),
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
    );
  }

  static showLoading({
    required BuildContext context,
    required String loadingMessage,
    bool isDismissible = false,
  })
  {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: 0,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircularProgressIndicator(
                color: AppColorsLight.pink,
                strokeWidth: 5,
              ),
              const SizedBox(width: AppSizes.sizedBoxWidth_9,),
              Text(
                loadingMessage,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(
                  color: AppColorsLight.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }
}
