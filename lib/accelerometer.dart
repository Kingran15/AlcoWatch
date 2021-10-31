import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerStuff extends StatefulWidget{
  @override
  _AccelerometerStuffState createState() => _AccelerometerStuffState();
}

class _AccelerometerStuffState extends State<AccelerometerStuff>{
  double x = 0;
  int fastCount = 0;
  Color background = Colors.green;
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
            background = Colors.red;
            stopTimer();
          }
        }
      });
    });
    // userAccelerometerEvents.listen((UserAccelerometerEvent event) {
    //   setState(() {
    //     xVel = event.x;
    //     //y = event.y;
    //     //z = event.z;
    //   });
    // }); //get the sensor data and set then to the data types
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
    return new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new Scaffold(
            backgroundColor: background,
            appBar: AppBar(
              title: Text("Flutter Sensor Library"),
              backgroundColor: Colors.lightGreen
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Transform.rotate(angle: x/10, child: Image.asset('assets/images/arrow_triangle.png', scale: 5)),
                  Text("$_count", style: TextStyle(fontSize: 120)),
                  Text(x.toStringAsFixed(2), style: TextStyle(fontSize: 50)),
                  Text(fastCount.toString(), style: TextStyle(fontSize: 50))
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(
                  //     "An Example How on Flutter Sensor library is used",
                  //     style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                  //   ),
                  // ),
                  // Table(
                  //   border: TableBorder.all(
                  //       width: 2.0,
                  //       color: Colors.greenAccent,
                  //       style: BorderStyle.solid),
                  //   children: [
                  //     TableRow(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             "X Axis : ",
                  //             style: TextStyle(fontSize: 20.0),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(x.toStringAsFixed(2), //trim the asis value to 2 digit after decimal point
                  //               style: TextStyle(fontSize: 20.0)),
                  //         )
                  //       ],
                  //     ),
                  //     TableRow(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             "X Velocity : ",
                  //             style: TextStyle(fontSize: 20.0),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(x.toStringAsFixed(2),  //trim the asis value to 2 digit after decimal point
                  //               style: TextStyle(fontSize: 20.0)),
                  //         )
                  //       ],
                  //     ),
                  //     TableRow(
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             "Z Asis : ",
                  //             style: TextStyle(fontSize: 20.0),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(z.toStringAsFixed(2),   //trim the asis value to 2 digit after decimal point
                  //               style: TextStyle(fontSize: 20.0)),
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ))
        )
    );
  }
}