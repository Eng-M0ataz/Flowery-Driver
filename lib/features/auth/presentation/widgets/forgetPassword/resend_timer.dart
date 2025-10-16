import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class ResendTimer extends StatelessWidget {
  const ResendTimer({super.key, required this.onEnd});

  final void Function()? onEnd;

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      format: CountDownTimerFormat.minutesSeconds,
      endTime: DateTime.now().add(const Duration(minutes: 3)),
      timeTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
      colonsTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
      enableDescriptions: false,
      spacerWidth: 0,
      onEnd: onEnd,
    );
  }
}
