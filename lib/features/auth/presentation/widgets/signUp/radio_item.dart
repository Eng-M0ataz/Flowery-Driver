import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  const RadioItem({
    super.key,
    required this.gender,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });
  final String gender;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          // ignore: deprecated_member_use
          groupValue: groupValue,
          // ignore: deprecated_member_use
          onChanged: onChanged,
        ),
        Text(gender, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
