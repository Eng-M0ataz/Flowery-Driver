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
  }) {
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
}
