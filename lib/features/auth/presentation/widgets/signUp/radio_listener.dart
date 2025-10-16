import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/radio_item.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/radio_widget.dart';
import 'package:flutter/material.dart';

class RadioItemListener extends StatelessWidget {
  const RadioItemListener({
    super.key,
    required this.gender,
    required this.value,
  });
  final String gender;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: RadioWidget.groupValueNotifier,
      builder: (context, groupValue, _) {
        return RadioItem(
          gender: gender,
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            RadioWidget.groupValueNotifier.value = val.toString();
          },
        );
      },
    );
  }
}
