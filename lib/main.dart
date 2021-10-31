// @dart=2.9

import 'package:drunk_proj/puzzle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child,
      ),
      home: Puzzle(),
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        barBackgroundColor: canvas,
        scaffoldBackgroundColor: background,
        primaryColor: green,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: "Avenir",
          ),
          tabLabelTextStyle: TextStyle(
            fontFamily: "Avenir",
            fontSize: 11,
          ),
          navTitleTextStyle: TextStyle(
            fontFamily: "Avenir",
            color: white,
            fontSize: 20,
          ),
          navLargeTitleTextStyle: TextStyle(
            fontFamily: "Avenir",
            color: white,
            fontSize: 40,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
