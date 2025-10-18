import 'package:flutter/material.dart';

class MiddleEllipsisText extends StatelessWidget {

  const MiddleEllipsisText({
    super.key,
    required this.text,
    this.maxLength = 20,
  });
  final String text;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    if (text.length <= maxLength) {
      return Text(text, style: Theme.of(context).textTheme.headlineLarge,);
    }

    final half = (maxLength - 3) ~/ 2;
    final firstPart = text.substring(0, half);
    final lastPart = text.substring(text.length - half);

    return Text('$firstPart...$lastPart', style: Theme.of(context).textTheme.headlineLarge,);
  }
}