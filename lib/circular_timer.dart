import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CircularTimer extends StatelessWidget {
  CircularTimer({
    Key key,
    @required this.context,
    @required CountDownController countController,
    @required this.timeForTimer,
    @required this.isStarted,
  }) : _countController = countController, super(key: key);

  final BuildContext context;
  final CountDownController _countController;
  final int timeForTimer;
  bool isStarted;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      controller: _countController,
      duration: timeForTimer < 1 ? 0 : timeForTimer,
      fillColor: Colors.cyanAccent,
      ringColor: Colors.white54,
      backgroundColor: Colors.transparent,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      isTimerTextShown: true,
      isReverse: true,
      isReverseAnimation: true,
      textStyle: TextStyle(fontSize: 40.0, color: Colors.white),
      onComplete: () {
        if(this.isStarted) {
          // print("1 istarted(oncomplete)");
          // print(isStarted);
          this.isStarted = false;
          Future.delayed(Duration(milliseconds: 50), (){
            CoolAlert.show(
              context: context,
              type: CoolAlertType.info,
              text: "Time is up!",
            );
          });
          // print("2 istarted(oncomplete)");
          // print(isStarted);
        }
      },
    );
  }
}
