import 'package:drunk_proj/constants.dart';
import 'package:drunk_proj/functions.dart';
import 'package:drunk_proj/main.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:blinking_text/blinking_text.dart';

class AccelerometerStuff extends StatefulWidget {

  @override
  _AccelerometerStuffState createState() => _AccelerometerStuffState();
}

class _AccelerometerStuffState extends State<AccelerometerStuff> {
  double x = 0;
  int fastCount = 0;
  Color background = Colors.green;
  bool drunk = false;
  // double xVel = 0;
  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event){
      setState((){
        x = event.x;
        if(_start == 30) {
          if (x.abs()> 0.5) {
            fastCount++;
          }

          if (fastCount > 18) {
            stopTimer();
            push(Result(false), context);
          }
        }
      });
    });

    startTimer();
  }

  Timer _timer;
  int _start = 10;
  int _count = 10;

  void startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_count == 0) {
          setState(() {
            if(_start == 10){
              _start = 30;
              _count = 30;
            } else if (_start == 30) {
              push(Result(true), context);
            }
            else{
              timer.cancel();
            }
          });
        } else {
          setState(() {
            _count--;
          });
        }
      },
    );
  }

  void stopTimer(){
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("$_count", style: TextStyle(fontSize: 120)),
            ],
          ),
        ),
      ),
    );
  }
}
