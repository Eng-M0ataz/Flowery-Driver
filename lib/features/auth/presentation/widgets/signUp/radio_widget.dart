import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/enum/gender_enum.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/auth/presentation/widgets/signUp/radio_listener.dart';
import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({super.key});

  static final ValueNotifier<String> groupValueNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.gender.tr(),
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: RadioItemListener(
            gender: LocaleKeys.female.tr(),
            value: GenderEnum.female.name,
          ),
        ),
        Expanded(
          flex: 4,
          child: RadioItemListener(
            gender: LocaleKeys.male.tr(),
            value: GenderEnum.male.name,
          ),
        ),
      ],
    );
  }
}
