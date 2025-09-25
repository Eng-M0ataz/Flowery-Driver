import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking/core/helpers/dialogue_utils.dart';
import 'package:flowery_tracking/core/localization/locale_keys.g.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flowery_tracking/features/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class MainTimer extends StatelessWidget {
  const MainTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
      buildWhen: (previous, current) =>
          previous.mainTimerEndTime != current.mainTimerEndTime,
      builder: (context, state) {
        final endTime = state.mainTimerEndTime;

        if (endTime == null) {
          return const SizedBox.shrink();
        }

        return TimerCountdown(
          format: CountDownTimerFormat.minutesSeconds,
          endTime: endTime,
          timeTextStyle: Theme.of(context).textTheme.headlineLarge,
          colonsTextStyle: Theme.of(context).textTheme.headlineLarge,
          enableDescriptions: false,
          spacerWidth: 0,
          onEnd: () {
            DialogueUtils.showMessage(
              context: context,
              message: LocaleKeys.resetCodeInvalidOrExpired.tr(),
              posActionName: LocaleKeys.ok.tr(),
              title: LocaleKeys.error.tr(),
            );
          },
        );
      },
    );
  }
}
