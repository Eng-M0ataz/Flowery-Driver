import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailsTextWidget extends StatelessWidget {
  const OrderDetailsTextWidget({super.key, required this.title});
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.spaceBetweenItems_24, bottom: AppSizes.spaceBetweenItems_16),
      child: Text(title, style: Theme.of(context).textTheme.displaySmall),
    );
  }
}
