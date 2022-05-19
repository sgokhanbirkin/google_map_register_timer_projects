import 'dart:async';

import 'package:examples/features/timer/widgets/button_widget.dart';
import 'package:examples/features/timer/widgets/greadient_widget.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds > 0) {
          setState(() {
            seconds--;
          });
        } else {
          stopTimer(reset: false);
        }
      },
    );
  }

  void resetTimer() => setState(() {
        seconds = maxSeconds;
      });

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() => timer?.cancel());
  }

  void resumeTimer() => startTimer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTimer(),
            const SizedBox(height: 80),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                text: isRunning ? 'Pause' : 'Resume',
                onClicked: isRunning
                    ? () {
                        stopTimer(reset: false);
                      }
                    : () {
                        resumeTimer();
                      },
              ),
              ButtonWidget(
                text: 'Cancel',
                onClicked: stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTimer() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              strokeWidth: 12,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              backgroundColor: Colors.greenAccent,
            ),
            Center(
              child: buildTime(),
            ),
          ],
        ),
      );

  Widget buildTime() {
    if (seconds == 0) {
      return const Icon(Icons.done, color: Colors.greenAccent, size: 100);
    } else {
      return Text(
        '$seconds',
        style: Theme.of(context).textTheme.headline1?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      );
    }
  }
}
