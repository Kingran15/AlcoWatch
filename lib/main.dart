import 'package:drunk_proj/accelerometer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() {
  runApp(AccelerometerStuff());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context), child: child),
      home: CupertinoPageScaffold(
          backgroundColor: background,
          child: Text('AlcoWatch')
      )
    );
  }
}
