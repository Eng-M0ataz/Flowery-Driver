import 'package:flowery_tracking/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BuildTitleWithSubtitle extends StatelessWidget {
  const BuildTitleWithSubtitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: AppSizes.spaceBetweenItems_16),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
