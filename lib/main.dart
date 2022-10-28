import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'circular_timer.dart';
import 'lap_template.dart';
import 'lap.dart';

//
// @author James Paul Josol BSIT - 3
//

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time",
      theme: ThemeData.dark(),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

  CountDownController _countController = CountDownController();
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  bool checkTimer = true;
  bool isStarted = false;

  @override
  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    setState(() {
      started = false;
      stopped = false;
      isStarted = true;
      _countController.restart(duration: timeForTimer);
    });

    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t) {
      setState(() {
        if(timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          timeForTimer = 0;
          checkTimer = true;
          started = true;
          stopped = true;
          // print("outside istarted");
          // print(isStarted);
          Future.delayed(Duration(milliseconds: 50), (){
            isStarted = false;
            // print("inside istarted");
            // print(isStarted);
          });
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //   builder: (context) => Homepage(),
          // ));
        }
        timeForTimer = timeForTimer - 1;
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
      isStarted = false;
      _countController.restart(duration: 0);
    });
  }

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //************** Timer code here below! *****************
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "HH",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      zeroPad: true,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 60.0,
                      selectedTextStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.cyanAccent,
                      ),
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 28.0),
                      child: Text(":", style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "MM",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      zeroPad: true,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      selectedTextStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.cyanAccent,
                      ),
                      onChanged: (val) {
                        setState(() {
                          min = val;
                        });
                      },
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 28.0),
                      child: Text(":", style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "SS",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      zeroPad: true,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      selectedTextStyle: TextStyle(
                        fontSize: 30.0,
                        color: Colors.cyanAccent,
                      ),
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            // child: CircularTimer(
            //   context: context,
            //   countController: _countController,
            //   timeForTimer: timeForTimer,
            //   isStarted: isStarted,
            // ),
            child: CircularCountDownTimer(
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
                  this.isStarted = false;
                  Future.delayed(Duration(milliseconds: 50), (){
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      text: "Time is up!",
                    );
                  });
                }
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: started ? start : null,
                  padding: EdgeInsets.all(10),
                  color: Colors.cyan,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.play_arrow,
                        size: 35,
                      ),
                      Text(
                        "Start",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  shape: CircleBorder(),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  padding: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.stop,
                        size: 35,
                      ),
                      Text(
                        "Stop",
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //************* Stopwatch code here below! **************
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String stopTimeDisplay = "00:00:00.00";
  String lapTimeDisplay = "00:00:00.00";
  var swatch = Stopwatch();
  var lapwatch = Stopwatch();
  final dur = const Duration(milliseconds: 40);

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if(swatch.isRunning) {
      startTimer();
    }
    setState(() {
      stopTimeDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") + ":"
                      + (swatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":"
                      + (swatch.elapsed.inSeconds%60).toString().padLeft(2, "0") + "."
                      + (swatch.elapsed.inMilliseconds%60).toString().padLeft(2, "0");
    });
  }


  void startStopWatch() {
    setState(() {
      stopIsPressed = false;
      startIsPressed = false;
    });
    swatch.start();
    startTimer();
  }

  void stopStopWatch() {
    setState(() {
      stopIsPressed = true;
      resetIsPressed = false;
      startIsPressed = true;
    });
    swatch.stop();
    lapwatch.stop();
  }

  void resetStopWatch() {
    setState(() {
      stopStopWatch();
      laps = [];
      isLapPressed = false;
    });
    swatch.reset();
    lapwatch.reset();
    stopTimeDisplay = "00:00:00.00";
    lapTimeDisplay = "00:00:00.00";
  }


  void startLap() {
    Timer(dur, keepLapRunning);
  }

  void keepLapRunning() {
    if(lapwatch.isRunning) {
      startLap();
    }
    setState(() {
      lapTimeDisplay = lapwatch.elapsed.inHours.toString().padLeft(2, "0") + ":"
          + (lapwatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":"
          + (lapwatch.elapsed.inSeconds%60).toString().padLeft(2, "0") + "."
          + (lapwatch.elapsed.inMilliseconds%60).toString().padLeft(2, "0");
    });
  }

  void startLapWatch() {
    lapwatch.start();
    startLap();
  }

  List<Lap> laps = [
  ];

  bool isLapPressed = false;

  void addLaps() {
    startLapWatch();
    laps.add(Lap(
          mainTime: stopTimeDisplay,
          lapTime: !isLapPressed ? stopTimeDisplay : lapTimeDisplay
      ));
    if(isLapPressed) lapwatch.reset();
    isLapPressed = true;
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: isLapPressed ? 4 : 8,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: stopTimeDisplay.substring(0, stopTimeDisplay.length-2),
                          style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: stopTimeDisplay.substring(stopTimeDisplay.length-2),
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: isLapPressed ? TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: lapTimeDisplay.substring(0, lapTimeDisplay.length-2),
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: lapTimeDisplay.substring(lapTimeDisplay.length-2),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ) : TextSpan(text: ''),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: isLapPressed ? 4 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    isLapPressed ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Lap",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          "Time",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ):Text(''),
                    isLapPressed ? Divider(
                      thickness: 2,
                      indent: 20.0,
                      endIndent: 20.0,
                      color: Colors.grey,
                    ):Text(''),
                    Column(
                      children: laps.map((lap) => LapTemplate(lap: lap, index: laps.indexOf(lap)+1)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: startIsPressed ? startStopWatch : stopStopWatch,
                        color: startIsPressed ? Colors.green : Colors.red,
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              startIsPressed ? Icons.play_arrow : Icons.pause,
                              size: 35,
                            ),
                            Text(
                              startIsPressed ? "Start" : "Pause",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        shape: CircleBorder(),
                      ),
                      RaisedButton(
                        onPressed: startIsPressed ? resetStopWatch : addLaps,
                        color: startIsPressed ? Colors.teal : Colors.cyan,
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              startIsPressed ? Icons.autorenew : Icons.flag,
                              size: 35,
                            ),
                            Text(
                              startIsPressed ? "Reset" : "Lap",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Project", style: TextStyle(fontSize: 25.0),),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.timer,
                ),
                Text("Timer"),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.access_alarms_sharp,
                ),
                Text("Stopwatch"),
              ],
            ),
          ],
          labelPadding: EdgeInsets.only(bottom: 10.0),
          labelStyle: TextStyle(
            fontSize: 18.0
          ),
          unselectedLabelColor: Colors.white54,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}

