import 'package:flutter/material.dart';

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