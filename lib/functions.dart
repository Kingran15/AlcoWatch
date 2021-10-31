import 'package:flutter/cupertino.dart';

List<Widget> verticalSpace(double gap, List<Widget> children) {
  children.removeWhere((element) => element == null);
  for (int i = 1; i < children.length; i+= 2) {
    children.insert(i, SizedBox(height: gap,));
  }
  return children;
}

List<Widget> horizontalSpace(double gap, List<Widget> children) {
  children.removeWhere((element) => element == null);
  for (int i = 1; i < children.length; i+= 2) {
    children.insert(i, SizedBox(width: gap,));
  }
  return children;
}

Future<T> push<T>(Widget page, BuildContext context) async {
  return Navigator.of(context).push(PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 200),
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(opacity: animation1, child: child,),
  ));
}

Future<T> showCustomDialog<T>(BuildContext context, Widget dialog) {
  return showCupertinoDialog<T>(context: context, builder: (context) => dialog, barrierDismissible: true);
}
